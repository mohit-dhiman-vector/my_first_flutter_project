import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String nameFromIntro;

  const MyHomePage(this.nameFromIntro, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Basics"),
      ),
      body: Center(child: Text('Welcome Main Page. $nameFromIntro')),
    );
  }
}
