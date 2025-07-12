import 'package:flutter/material.dart';
import 'package:savingmoney/projects/controller/authentication/user_authentication.dart';
import 'package:savingmoney/projects/view/home.dart';
import 'package:savingmoney/projects/view/login.dart';

class UserController {
  static Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final success = await UserAuthentication.login(
      email: email,
      password: password,
    );
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login Gagal')));
    }
  }

  static Future<void> register({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
  }) async {
    final succes = await UserAuthentication.register(
      username: username,
      email: email,
      password: password,
    );
    if (succes) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Register Gagal')));
    }
  }
}
