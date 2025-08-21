import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/IntroPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.blueAccent));
  }
}
