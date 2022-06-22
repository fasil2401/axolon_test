import 'package:flutter/material.dart';

import 'constants/colors.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: commonScaffoldBack,
      appBar: AppBar(
          backgroundColor: splashBackColor,
          automaticallyImplyLeading: true,
          title: const Text(
            'Map View',
            style: TextStyle(fontFamily: 'Rubik'),
          ),
          ),
    );
  }
}