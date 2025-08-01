import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/app/config.dart';
import 'package:flutter_app/data/model/login_response.dart';
import 'package:flutter_app/data/model/register_response.dart';
import 'package:get_storage/get_storage.dart';

class AuthRepository {
  Future<LoginResponse> loginFunction(Map<String, dynamic> request) async {
    Dio dio = Dio();
    try {
      var result = await dio.post("$url/login", data: request);
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
      var result = await dio.post("$url/register", data: request);
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
      await dio.post("$url/logout");
      return true;
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        throw Exception(e.response!.data);
      } else {
        throw Exception(e.response!.statusMessage);
      }
    }
  }

  Future createUserFirebase(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String> signInFirebase(String email, String password) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
