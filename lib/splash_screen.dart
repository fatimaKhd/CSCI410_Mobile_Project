import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Sweet Recipes',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
      ),
    );
  }
}
