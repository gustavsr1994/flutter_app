import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/repository/product_repository.dart';
import 'package:image_picker/image_picker.dart';

class FormProductController extends ChangeNotifier {
  TextEditingController nameField = TextEditingController();
  TextEditingController descriptionField = TextEditingController();
  TextEditingController priceField = TextEditingController();
  TextEditingController stockField = TextEditingController();
  File imageFile = File("");

  Future detailProduct(int id) async {
    var result = await ProductRepository().fetchDetailProduct(id);
    if (id != 0) {
      nameField.text = result.data!.title!;
      descriptionField.text = result.data!.description!;
      priceField.text = result.data!.price.toString();
      stockField.text = result.data!.price.toString();
    } else {
      nameField.clear();
      descriptionField.clear();
      priceField.clear();
      stockField.clear();
      imageFile = File("");
    }
  }

  void openPickImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.sizeOf(context).height / 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => openGallery(context),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.folder), Text("Open Gallery")],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => captureCamera(context),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      Text("Open Camera")
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void captureCamera(BuildContext context) async {
    var result = await ImagePicker().pickImage(source: ImageSource.camera);
    imageFile = File(result!.path);
    Navigator.pop(context);
    notifyListeners();
  }

  void openGallery(BuildContext context) async {
    var result = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(result!.path);
    Navigator.pop(context);
    notifyListeners();
  }

  void actionSubmit(BuildContext context) async {
    var request = {
      "title": nameField.text,
      "description": descriptionField.text,
      "price": priceField.text,
      "stock": stockField.text,
      "image": await MultipartFile.fromFile(imageFile.path,
          filename: imageFile.path.split("/").last)
    };
    try {
      await ProductRepository().insertNewProduct(request);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed Submit")));
    }
  }

  void actionSubmitUpdate(BuildContext context, int id) async {
    var request = {
      "_method": "PUT",
      "title": nameField.text,
      "description": descriptionField.text,
      "price": priceField.text,
      "stock": stockField.text,
    };
    try {
      await ProductRepository().updateProduct(id, request);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed Submit")));
    }
  }
}
