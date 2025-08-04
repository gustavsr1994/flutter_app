import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

class HomeListEmployeePage extends StatefulWidget {
  const HomeListEmployeePage({super.key});

  @override
  State<HomeListEmployeePage> createState() => _HomeListEmployeePageState();
}

class _HomeListEmployeePageState extends State<HomeListEmployeePage> {
  CollectionReference _itemCollection =
      FirebaseFirestore.instance.collection("employees");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Karyawan"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _itemCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return Card(
                      child: ListTile(
                        title:
                            Text("${item["first_name"]} ${item["last_name"]}"),
                        subtitle: Text(DateFormat('dd - MMM - yyyy')
                            .format(item['birthdate'].toDate())),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  "Loading ... ",
                  style: TextStyle(color: Colors.green),
                ),
              );
            }
          }),
    );
  }
}
