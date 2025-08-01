import 'package:flutter/material.dart';
import 'package:flutter_app/data/repository/product_repository.dart';

class DetailProductPage extends StatelessWidget {
  final int id;
  const DetailProductPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product"),
      ),
      body: FutureBuilder(
        future: ProductRepository().fetchDetailProduct(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var item = snapshot.data!.data;
              return ListView(
                children: [
                  ListTile(
                    title: Text("Name Product"),
                    subtitle: Text(item!.title!),
                  ),
                  ListTile(
                    title: Text("Price"),
                    subtitle: Text(item.price.toString()),
                  ),
                  ListTile(
                    title: Text("Stock"),
                    subtitle: Text(item.stock.toString()),
                  ),
                  ListTile(
                    title: Text("Description"),
                    subtitle: Text(item.description!),
                  )
                ],
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
      ),
    );
  }
}
