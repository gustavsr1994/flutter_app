import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/employee/form_new_employee_page.dart';
import 'package:get/get.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(FormNewEmployeePage(""));
        },
        child: Icon(Icons.add),
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
                    String documentId = snapshot.data!.docs[index].id;
                    return Card(
                      child: ListTile(
                          title: Text(
                              "${item["first_name"]} ${item["last_name"]}"),
                          subtitle: Row(
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      _itemCollection.doc(documentId).delete(),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                              IconButton(
                                  onPressed: () => Get.to(FormNewEmployeePage(documentId)),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  )),
                              IconButton(
                                  onPressed: () => openDetail(item),
                                  icon: Icon(
                                    Icons.visibility,
                                    color: Colors.blue,
                                  ))
                            ],
                          )),
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

  void openDetail(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${data['first_name']} ${data['last_name']}"),
        content: Text(
            "Tanggal Lahir: ${DateFormat('dd - MMM - yyyy').format(data['birthdate'].toDate())}"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Dismiss"))
        ],
      ),
    );
  }
}
