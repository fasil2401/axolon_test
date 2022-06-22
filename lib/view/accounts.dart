import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview_axolon/controller/account_control.dart';
import 'package:interview_axolon/view/constants/heights.dart';
import 'package:interview_axolon/view/constants/paddings.dart';
import 'package:sizer/sizer.dart';

import 'components/custom_text.dart';
import 'components/name_text.dart';
import 'constants/border_radius.dart';
import 'constants/colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final controller = Get.put(AccountsController());
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
          Get.toNamed('/add');
        },
        child: Icon(Icons.add),
        backgroundColor: splashBackColor,
      ),
      body: GetBuilder<AccountsController>(
        builder: (cont) {
          return Padding(
            padding: commonHorizontalPadding,
            child: ListView.separated(
              itemCount: cont.observableBox.length,
              itemBuilder: (context, index) {
                List<dynamic> data = cont.observableBox.values.toList();
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: commonRadius,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25.w,
                          width: 25.w,
                          child: data[index].imagePath == null
                              ? ClipRRect(
                                  borderRadius: commonRadius,
                                  child: Image.asset(
                                    'asset/images/profile.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: commonRadius,
                                  child: Image.file(
                                    File(data[index].imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50.w,
                              child: NameText(
                                name: data[index].name ?? "N/A",
                              ),
                            ),
                            CustomText(
                              text: 'Roll Number : ${data[index].roll ?? "N/A"}',
                              size: 14.sp,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => commonHeight2,
            ),
          );
        },
      ),
    );
  }
}
