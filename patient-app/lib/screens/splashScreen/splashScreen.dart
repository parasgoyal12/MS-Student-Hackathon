import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/widgets/IconImages.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: TreatmentIconLogo(),)
    );
  }
}
