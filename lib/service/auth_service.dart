import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api.dart';
import '../model/user_model.dart';

class AuthService {
  /*
  |--------------------------------------------------------------------------
  | REGISTER
  |--------------------------------------------------------------------------
  */

  static Future<UserModel?> register({
    required String nama,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Api.register),
        body: {
          "name": nama,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return UserModel.fromJson(
          data["data"],
        );
      }

      return null;
    } catch (e) {
      print(e);

      return null;
    }
  }

  /*
  |--------------------------------------------------------------------------
  | LOGIN
  |--------------------------------------------------------------------------
  */

  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          Api.login,
        ),
        body: {
          "email": email,
          "password": password,
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(
          response.body,
        );

        return UserModel.fromJson(
          data["data"],
        );
      }

      return null;
    } catch (e) {
      print(
        "LOGIN ERROR : $e",
      );

      return null;
    }
  }
}
