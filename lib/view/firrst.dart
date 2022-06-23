import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_axolon/main.dart';


class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

@override
  void initState() {
    super.initState();

navigate();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  navigate()async{
    final state = preferences!.getBool('isLogin');

    if(state == true){
      Get.toNamed('/home');
  }
  else{
    Get.toNamed('/login');
  }
  }
}