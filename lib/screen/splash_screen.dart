// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/dashboard_screen.dart';
import 'package:flutter_application_2/screen/login_page.dart';
import 'package:flutter_application_2/screen/login_with_provider_page.dart';

import 'package:flutter_application_2/utils/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUserLogin() async {
    Timer(const Duration(seconds: 3), () async {
      String cekDataLogin = await getToken();

      if (cekDataLogin.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPageScreenWithProvider(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.flutter_dash,
          size: 86,
        ),
      ),
    );
  }
}
