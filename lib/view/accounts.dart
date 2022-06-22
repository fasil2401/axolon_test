import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  final _accounts = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commonScaffoldBack,
      appBar: AppBar(
          backgroundColor: splashBackColor,
          automaticallyImplyLeading: true,
          title: const Text(
            'Accounts',
            style: TextStyle(fontFamily: 'Rubik'),
          ),
          actions: [IconButton(icon: const Icon(Icons.map), onPressed: () {Get.toNamed('/map');})]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add');
        },
        child: Icon(Icons.add),
        backgroundColor: splashBackColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<AccountsController>(
              builder: (cont) {
                return Padding(
                  padding: commonHorizontalPadding,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cont.observableBox.length,
                    itemBuilder: (context, index) {
                      List<dynamic> data = cont.observableBox.values.toList();
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[300],
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
              commonHeight2,
            StreamBuilder<QuerySnapshot>(
              stream: _accounts.collection('accounts').snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var list = snapshot.data!.docs;
      
                  return Padding(
                    padding: commonHorizontalPadding,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: commonRadius,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.w),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 25.w,
                                  width: 25.w,
                                  child: list[index]['imagePath'] == null
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
                                            File(list[index]['imagePath']),
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
                                        name: list[index]['name'] ?? "N/A",
                                      ),
                                    ),
                                    CustomText(
                                      text: 'Roll Number : ${list[index]['roll'] ?? "N/A"}',
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
                }
                return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ));
              },
              
              
              )
          ],
        ),
      ),
    );
  }
}
