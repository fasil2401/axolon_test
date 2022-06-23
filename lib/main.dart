import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview_axolon/view/account_add.dart';
import 'package:interview_axolon/view/accounts.dart';
import 'package:interview_axolon/view/firrst.dart';
import 'package:interview_axolon/view/homescreen.dart';
import 'package:interview_axolon/view/location_tracking.dart';
import 'package:interview_axolon/view/login_screen.dart';
import 'package:interview_axolon/view/map.dart';
import 'package:interview_axolon/view/map_view.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Repository/box_repository.dart';
import 'model/account.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? preferences;

void main() async{

   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(AccountsAdapter());
  await BoxRepository.openBox();

  preferences = await SharedPreferences.getInstance();
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
          initialRoute: '/login',

          getPages: [
            GetPage(name: '/', page: ()=>  FirstScreen(),
            transition: Transition.cupertino
            ),
            GetPage(name: '/login', page: ()=>  LoginScreen(),
            transition: Transition.cupertino
            ),
             GetPage(name: '/map', page: ()=>  LocationTracking(),
            transition: Transition.cupertino
            ),
             GetPage(name: '/home', page: ()=> const HomePage(),
            transition: Transition.cupertino
            ),
            GetPage(name: '/account', page: ()=> const AccountPage(),
            transition: Transition.cupertino
            ),
            GetPage(name: '/add', page: ()=>  AccountAdd(),
            transition: Transition.cupertino
            )
          ],
        );
      }
    );
  }
}

