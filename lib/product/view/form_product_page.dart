import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/product/controller/form_product_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FormProductPage extends StatefulWidget {
  const FormProductPage({super.key});

  @override
  State<FormProductPage> createState() => _FormProductPageState();
}

class _FormProductPageState extends State<FormProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Insert New Product"),
      ),
      body: Consumer<FormProductController>(
        builder: (context, state, _) {
          return ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  controller: state.nameField,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field ini belum diisi";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Nama Produk', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  controller: state.priceField,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field ini belum diisi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Harga Produk', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  controller: state.stockField,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field ini belum diisi";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Stok Produk', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  controller: state.descriptionField,
                  maxLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field ini belum diisi";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Deskripsi Produk',
                      border: OutlineInputBorder()),
                ),
              ),
              ElevatedButton(
                  onPressed: () => state.openPickImage(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900]),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "Pick Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              state.imageFile.path.isEmpty
                  ? SizedBox()
                  : Container(
                      height: MediaQuery.sizeOf(context).height / 3,
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: Image.file(state.imageFile),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red)),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () => state.actionSubmit(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900]),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ))
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
