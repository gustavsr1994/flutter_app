import 'dart:ffi';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ConfigNotification {
  AwesomeNotifications _awesomeNotifications = AwesomeNotifications();

  void initialNotification() async {
    var tokenFirebase = await FirebaseMessaging.instance.getToken();
    print("Token Firebase: $tokenFirebase");
    await _awesomeNotifications.initialize(null, [
      NotificationChannel(
        channelKey: 'notif-local',
        channelName: 'Notif-Local-1',
        channelDescription: 'Notif Local 1',
        channelShowBadge: true,
      )
    ]);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, sound: true);
    FirebaseMessaging.onMessage.listen(
      (event) => showNotification(
          event.notification!.title ?? '', event.notification!.body ?? ''),
    );
    FirebaseMessaging.onBackgroundMessage(
      (event) => showNotification(
          event.notification!.title ?? '', event.notification!.body ?? ''),
    );
  }

  Future showNotification(String title, String body) async {
    // await awesomeNotification
    await _awesomeNotifications.createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'notif-local',
            title: title,
            body: body,
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture:
                'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png'));
  }
}
