import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meuni_mobile/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => StackedService.navigatorKey!.currentState!.pushReplacementNamed(
        Routes.startupView,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/slashScreen.png'), // Your splash screen image asset
      ),
    );
  }
}
