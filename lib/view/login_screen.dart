import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_axolon/main.dart';
import 'package:interview_axolon/view/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../controller/form validation/login_control.dart';
import 'components/error_text.dart';
import 'components/welcome_text.dart';
import 'constants/heights.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final loginControl = Get.put(LoginFormControl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commonScaffoldBack,
      appBar: AppBar(
        backgroundColor: splashBackColor,
        title: const Text(
          'Login Page',
          style: TextStyle(fontFamily: 'Rubik'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: SizedBox(
            height: 80.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const WelcomeText(
                  title: 'Welcome to Axolon',
                ),
                commonHeight5,
                CupertinoTextField(
                  // controller: _emailorphoneController,
                  onChanged: (value) {
                    loginControl.validateEmailorphone(value);
                  },
                  decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  style: TextStyle(fontSize: 16.sp),
                  placeholder: 'Enter Your email or phone',
                  placeholderStyle: TextStyle(
                      color: CupertinoColors.placeholderText,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w200,
                      fontSize: 14.sp),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Icon(
                      Icons.email,
                      color: CupertinoColors.placeholderText,
                    ),
                  ),
                ),
                 Obx(
                   ()=> ErrorText(
                    title: 'Enter valid Email',
                    isVisible: loginControl.email.value,
                                 ),
                 ),
                commonHeight2,
                
                  CupertinoTextField(
                    // controller: _passwordController,
                    onChanged: (value) {
                      loginControl.validatePassword(value);
                    },
                    decoration: BoxDecoration(
                      color: textFieldColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    style: TextStyle(fontSize: 16.sp),
                    placeholder: 'Enter Your Password',
                    obscureText: true,
                    placeholderStyle: TextStyle(
                        color: CupertinoColors.placeholderText,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w200,
                        fontSize: 14.sp),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    prefix: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.lock,
                        color: CupertinoColors.placeholderText,
                      ),
                    ),
                  ),
                  Obx(
                   ()=> ErrorText(
                    title: 'password should be 10 characters',
                    isVisible: loginControl.password.value,
                                 ),
                 ),
                
                commonHeight2,
                
                commonHeight2,
                SizedBox(
                  height: 5.5.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: textBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      loginControl.checkLoginForm();
                      preferences!.setBool('isLogin', true);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: textFieldColor,
                        fontSize: 16.sp,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                commonHeight2,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
