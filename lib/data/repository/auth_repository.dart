import 'package:dio/dio.dart';
import 'package:flutter_app/data/model/login_response.dart';
import 'package:flutter_app/data/model/register_response.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepository {
  Future<LoginResponse> loginFunction(Map<String, dynamic> request) async {
    Dio dio = Dio();
    try {
      var result =
          await dio.post("http://10.0.2.2:8000/api/login", data: request);
      return LoginResponse.fromJson(result.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }

  Future<RegisterResponse> registerFunction(
      Map<String, dynamic> request) async {
    Dio dio = Dio();
    try {
      var result =
          await dio.post("http://10.0.2.2:8000/api/register", data: request);
      return RegisterResponse.fromJson(result.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }

  Future<bool> logoutFunction() async {
    final box = GetStorage();
    var token = box.read("token");
    Dio dio = Dio();
    try {
      dio.options = BaseOptions(headers: {"Authorization": "Bearer $token"});
      await dio.post("http://10.0.2.2:8000/api/logout");
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
