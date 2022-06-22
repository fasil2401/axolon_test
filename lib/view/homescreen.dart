import 'package:flutter/material.dart';
import 'package:interview_axolon/view/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commonScaffoldBack,
      appBar: AppBar(
        backgroundColor: splashBackColor,
        automaticallyImplyLeading: false,
        title: const Text('Home Page', style: TextStyle(fontFamily: 'Rubik'),),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
             }
          )
        ]
      ),
    );
  }
}