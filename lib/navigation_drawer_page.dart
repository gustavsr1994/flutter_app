import 'package:flutter/material.dart';

class NavigationDrawerPage extends StatefulWidget {
  const NavigationDrawerPage({super.key});

  @override
  State<NavigationDrawerPage> createState() => _NavigationDrawerPageState();
}

class _NavigationDrawerPageState extends State<NavigationDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerWidget(),
      endDrawer: drawerWidget(),
      appBar: AppBar(
        title: Text("Navigation Drawer Page"),
      ),
    );
  }

  Widget drawerWidget(){
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                child: Text("Gustav")),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text("Bookmark"),
              // subtitle: Text("data"),
            ),
            Divider(
              color: Colors.amber,
            ),
            ListTile(
              leading: Icon(Icons.portrait),
              title: Text("My Profile"),
              // subtitle: Text("data"),
            ),
          ],
        ),
      );
  }
}
