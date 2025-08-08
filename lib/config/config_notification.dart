import 'dart:ffi';

import 'package:awesome_notifications/awesome_notifications.dart';

class ConfigNotification {
  AwesomeNotifications _awesomeNotifications = AwesomeNotifications();

  void initialNotification() async {
    await _awesomeNotifications.initialize(null, [
      NotificationChannel(
        channelKey: 'notif-local',
        channelName: 'Notif-Local-1',
        channelDescription: 'Notif Local 1',
        channelShowBadge: true,
      )
    ]);
  }

  Future showNotification() async {
    // await awesomeNotification
    await _awesomeNotifications.createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'notif-local',
            title: "Uji coba Notifikasi Image",
            body: "Lokal Notifikasi",
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture:
                'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png'));
  }
}
