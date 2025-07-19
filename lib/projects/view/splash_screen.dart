import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savingmoney/projects/controller/user_provider.dart';
import 'package:savingmoney/projects/view/home.dart';
import 'package:savingmoney/projects/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Center(child: CircularProgressIndicator()),
            Text('Please Wait'),
          ],
        ),
      ),
    );
  }
}
