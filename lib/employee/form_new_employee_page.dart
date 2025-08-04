import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormNewEmployeePage extends StatefulWidget {
  final String documentId;
  const FormNewEmployeePage(this.documentId, {super.key});

  @override
  State<FormNewEmployeePage> createState() => _FormNewEmployeePageState();
}

class _FormNewEmployeePageState extends State<FormNewEmployeePage> {
  CollectionReference _itemCollection =
      FirebaseFirestore.instance.collection("employees");
  TextEditingController firstNameField = TextEditingController();
  TextEditingController lastNameField = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.documentId != "") {
      fetchDetailEmployee();
    }
  }

  void fetchDetailEmployee() async {
    var result = await _itemCollection.doc(widget.documentId).get();
    var item = result.data() as Map<String, dynamic>;
    firstNameField.text = item['first_name'];
    lastNameField.text = item['last_name'];
    birthDate.text =
        DateFormat("dd MMMM yyyy").format(item['birthdate'].toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentId == ""
            ? "Form Update Employee"
            : "Form New Employee"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: firstNameField,
              decoration: InputDecoration(labelText: "First Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: lastNameField,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: birthDate,
              decoration: InputDecoration(
                  labelText: "Birth Date",
                  suffixIcon: IconButton(
                      onPressed: () => openDatePicker(context),
                      icon: Icon(Icons.calendar_month_rounded))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red)),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  )),
              ElevatedButton(
                  onPressed: () => actionSubmit(),
                  style:
                      OutlinedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future openDatePicker(BuildContext context) async {
    final DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(DateTime.now().year + 1));
    if (pickerDate != null) {
      birthDate.text = DateFormat("dd MMMM yyyy").format(pickerDate);
      setState(() {});
    }
  }

  void actionSubmit() async {
    try {
      if (widget.documentId == "") {
        await _itemCollection.add({
          'first_name': firstNameField.text,
          'last_name': lastNameField.text,
          'birthdate': DateFormat("dd MMMM yyyy").parse(birthDate.text)
        });
      } else {
        await _itemCollection.doc(widget.documentId).update({
          'first_name': firstNameField.text,
          'last_name': lastNameField.text,
          'birthdate': DateFormat("dd MMMM yyyy").parse(birthDate.text)
        });
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }
}
