import 'package:expense_tracker/repository/screens/homescreen/homescreen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashscreenState();
  const Splashscreen({super.key});
}

class SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
