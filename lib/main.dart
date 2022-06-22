import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_axolon/view/accounts.dart';
import 'package:interview_axolon/view/homescreen.dart';
import 'package:interview_axolon/view/login_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          // home: const HomePage(),
          initialRoute: '/',

          getPages: [
            GetPage(name: '/', page: ()=>  LoginScreen(),
            transition: Transition.cupertino
            ),
             GetPage(name: '/home', page: ()=> const HomePage(),
            transition: Transition.cupertino
            ),
            GetPage(name: '/account', page: ()=> const AccountPage(),
            transition: Transition.cupertino
            )
          ],
        );
      }
    );
  }
}

