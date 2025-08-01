import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/all_product_response.dart';
import 'package:flutter_app/data/repository/product_repository.dart';
import 'package:flutter_app/product/view/detail_product_page.dart';
import 'package:flutter_app/product/view/form_product_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/repository/auth_repository.dart';
import '../../provider/login_page_provider.dart';

class MainProductPage extends StatefulWidget {
  const MainProductPage({super.key});

  @override
  State<MainProductPage> createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(
            "Daftar Produk",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => actionLogOut(),
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(FormProductPage(0)),
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<List<DataProduct>>(
          stream: getAllProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(item.image!),
                        title: Text(item.title!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Stock: ${item.stock}"),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        Get.to(DetailProductPage(item.id!)),
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () => Get.to(FormProductPage(item.id!)),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () => actionDelete(item.id!),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )
                          ],
                        ),
                        trailing: Text("Rp. ${item.price}"),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("No Data"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void actionDelete(int id) async {
    try {
      var result = await ProductRepository().deleteProduct(id);
      if (result) {
        setState(() {});
        Get.snackbar("Success", "",
            backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Failed Delete", "Message: ${e.toString()}",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Stream<List<DataProduct>> getAllProduct() async* {
    ProductRepository _productRepo = ProductRepository();
    var result = await _productRepo.fetchAllProduct();
    yield result.data!;
  }

  void actionLogOut() async {
    final box = GetStorage();
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
}
