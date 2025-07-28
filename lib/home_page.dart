import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: Icon(
            Icons.home,
            color: Colors.red,
          ),
          title: Text(
            "Home Page",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Icon(
              Icons.star,
              color: Colors.red,
            ),
            Icon(
              Icons.shopping_bag,
              color: Colors.red,
            )
          ],
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height / 2,
          margin: EdgeInsets.only(right: 20, top: 50), // spasi keluar
          padding: EdgeInsets.all(30), // spasi kedalam
          color: Colors.amber,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.green, width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Container Satu Satu"),
                  Text("Container Dua"),
                  Text("Container Tiga Tiga Tiga"),
                ],
              ))),
        ));
  }
}
