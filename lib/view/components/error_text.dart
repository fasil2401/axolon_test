



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';


class ErrorText extends StatelessWidget {
  final String title;
  final bool isVisible;
  const ErrorText({
    Key? key,required this.title,  this.isVisible = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyle(
            color: textBlueColor,
            fontSize: 10.sp,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
