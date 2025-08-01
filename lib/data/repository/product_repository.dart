import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/all_product_response.dart';
import 'package:flutter_app/data/model/detail_product_response.dart';
import 'package:flutter_app/data/model/insert_product_response.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/config.dart';

class ProductRepository {
  Dio dio = Dio();
  Future<AllProductResponse> fetchAllProduct() async {
    final box = GetStorage();
    var token = box.read("token");
    try {
      dio.options = BaseOptions(headers: {"Authorization": "Bearer $token"});
      var result = await dio.get("$url/products");
      return AllProductResponse.fromJson(result.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }

  Future<DetailProductResponse> fetchDetailProduct(int id) async {
    final box = GetStorage();
    var token = box.read("token");
    try {
      dio.options = BaseOptions(headers: {"Authorization": "Bearer $token"});
      var result = await dio.get("$url/products/$id");
      return DetailProductResponse.fromJson(result.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }

  Future<InsertProductResponse> insertNewProduct(
      Map<String, dynamic> request) async {
    final box = GetStorage();
    var token = box.read("token");
    try {
      dio.options = BaseOptions(headers: {"Authorization": "Bearer $token"});
      var result = await dio.post("$url/products", data: FormData.fromMap(request));
      return InsertProductResponse.fromJson(result.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }

  void updateProduct() {}

  Future<bool> deleteProduct(int id) async {
    final box = GetStorage();
    var token = box.read("token");
    try {
      dio.options = BaseOptions(headers: {"Authorization": "Bearer $token"});
      await dio.delete("$url/products/$id");
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }
}
