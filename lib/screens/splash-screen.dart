import 'package:flutter/material.dart';
import 'package:tripawy_demo/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Loading...')),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
