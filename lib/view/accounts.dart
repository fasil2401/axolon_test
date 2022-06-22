import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_axolon/view/constants/heights.dart';
import 'package:sizer/sizer.dart';

import 'constants/colors.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

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
          actions: [IconButton(icon: const Icon(Icons.map), onPressed: () {})]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController _nameController = TextEditingController();
          TextEditingController _rollController = TextEditingController();
          Get.defaultDialog(
              title: 'Add Account',
              content: Column(
                children: [
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
                                }}
                    },
                    controller: _rollController,
                    decoration: inputDecorate('Enter Roll number', 'Roll number'),
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
                ],
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: splashBackColor,
      ),
    );
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
