import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview_axolon/controller/account_control.dart';
import 'package:interview_axolon/model/account.dart';
import 'package:interview_axolon/model/firebase_model.dart';
import 'package:interview_axolon/view/constants/paddings.dart';
import 'package:sizer/sizer.dart';

import '../services/firebase_services.dart';
import 'constants/border_radius.dart';
import 'constants/colors.dart';
import 'constants/heights.dart';

class AccountAdd extends StatefulWidget {
  AccountAdd({Key? key}) : super(key: key);

  @override
  State<AccountAdd> createState() => _AccountAddState();
}

class _AccountAddState extends State<AccountAdd> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _rollController = TextEditingController();

  final services = Services();
final controller = Get.put(AccountsController());
  XFile? _image;

  dynamic _imagePath;

  Future getImage() async {
    final ImagePicker image = ImagePicker();
    _image = await image.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {});
      _imagePath = _image!.path;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: commonScaffoldBack,
        appBar: AppBar(
          backgroundColor: splashBackColor,
          automaticallyImplyLeading: false,
          title: const Text(
            'Accounts',
            style: TextStyle(fontFamily: 'Rubik'),
          ),
        ),
        body: Padding(
          padding: commonHorizontalPadding,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonHeight5,
                  commonHeight5,
                  commonHeight5,
                  Stack(
                    children: [
                      _image == null
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 40.w,
                                width: 40.w,
                                child: ClipRRect(
                                  borderRadius: commonRadius,
                                  child: Image.asset(
                                    'asset/images/profile.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: 40.w,
                                width: 40.w,
                                child: ClipRRect(
                                  borderRadius: commonRadius,
                                  child: Image.file(
                                    File(_imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: Container(
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: textBlueColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(3.w),
                                  bottomRight: Radius.circular(3.w),
                                ),
                              ),
                              child:const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'Upload',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  commonHeight4,
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter name";
                      } else {
                        if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                            .hasMatch(value)) {
                          return "please enter a valid name";
                        }
                        return null;
                      }
                    },
                    controller: _nameController,
                    decoration: inputDecorate('Enter Name', 'Name'),
                  ),
                  commonHeight2,
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter Roll number";
                      } else {
                        if (RegExp(r'^[0-9]*$').hasMatch(value) &&
                            value.length < 3) {
                          return null;
                        } else {
                          return "invalid input";
                        }
                      }
                    },
                    controller: _rollController,
                    decoration:
                        inputDecorate('Enter Roll number', 'Roll number'),
                  ),
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
                        // loginControl.checkLoginForm();
                        bool? isValidated = _formKey.currentState?.validate();
                    if (isValidated == true) {
                      String nameText = _nameController.text;
                      String rollText = _rollController.text;
                      controller.createAccount(account: Accounts(
                        name: nameText,
                        roll: int.parse(rollText),
                        imagePath: _imagePath,
                      ));
                      // Get.back();

                      }
                      else{
                        Get.snackbar('Alert', 'Please Enter Valid Text', snackPosition: SnackPosition.BOTTOM);
                      }
                      },
                      child: Text(
                        "Save",
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
                      onPressed: () async{
                        // loginControl.checkLoginForm();
                        bool? isValidated = _formKey.currentState?.validate();
                    if (isValidated == true) {
                      String nameText = _nameController.text;
                      String rollText = _rollController.text;
                      
                     final account = Acccount(name: nameText, roll: int.parse(rollText), isFirebase: true, imagePath: _imagePath);
                      services.createAccount(account);
                      Get.back();

                      }
                      else{
                        Get.snackbar('Alert', 'Please Enter Valid Text', snackPosition: SnackPosition.BOTTOM);
                      }
                      },
                      child: Text(
                        "Save to Firebase",
                        style: TextStyle(
                          color: textFieldColor,
                          fontSize: 16.sp,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  InputDecoration inputDecorate(String hint, String label) {
    return InputDecoration(
      isDense: true,
      filled: true,
      labelText: label,
      labelStyle: TextStyle(
          color: const Color.fromARGB(255, 39, 1, 93),
          fontFamily: 'Rubik',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600),
      hintText: hint,
      fillColor: Colors.blue.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
