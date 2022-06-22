import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';


class WelcomeText extends StatelessWidget {

  final String title;
  const WelcomeText({
    Key? key,required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
    style: TextStyle(
      color: commonBlack,
      fontSize: 22.sp,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700
    ),
    );
  }
}