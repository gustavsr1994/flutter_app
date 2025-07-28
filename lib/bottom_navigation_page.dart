import 'package:flutter/material.dart';
import 'package:flutter_app/data/repository/auth_repository.dart';
import 'package:flutter_app/provider/login_page_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final box = GetStorage();
  int indexTabSelected = 1;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = box.read("name");
  }

  void actionLogOut() async {
    AuthRepository _authRepository = AuthRepository();
    try {
      await _authRepository.logoutFunction();
      box.erase();
      Get.off(LoginPageProvider());
    } catch (e) {
      Get.snackbar("Error", "Message: ${e.toString()}",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: SizedBox(),
        title: Text("Bottom Navigation Page"),
        actions: [
          IconButton(onPressed: () => actionLogOut(), icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(name ?? ""),
      ), //bodyWidget(indexTabSelected),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexTabSelected,
          onTap: (value) {
            setState(() {
              indexTabSelected = value;
            });
          },
          selectedItemColor: Colors.red,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: 'Bookmark'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.portrait), label: 'Profile')
          ]),
    );
  }

  Future<List<String>> getValue() async {
    await Future.delayed(Duration(seconds: 5));
    return List.generate(
      50,
      (index) => "Data ke - $index",
    ).toList();
  }

  Stream<int> countStream() async* {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 5));
      yield i;
    }
  }

  Widget bodyWidget(int index) {
    switch (index) {
      case 0:
        return FutureBuilder(
          future: getValue(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => Card(
                    child: Text(snapshot.data![index]),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(
                  "Error",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        );
      case 1:
        return StreamBuilder(
          stream: countStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(
                  "Error Stream: ${snapshot.connectionState}",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        );
      case 2:
        return Center(
          child: Text("Ini halaman profile saya"),
        );
      default:
        return SizedBox();
    }
  }
}
