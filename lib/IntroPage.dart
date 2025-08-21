import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/MyHomePage.dart';

class IntroPage extends StatelessWidget {
  var textController = TextEditingController();

  IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intro Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Intro Page.'),
            SizedBox(height: 15),
            TextField(controller: textController),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(textController.text.toString())),
                );
              },
              child: Text('Click'),
            ),
          ],
        ),
      ),
    );
  }
}
