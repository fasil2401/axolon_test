

import 'package:hive_flutter/hive_flutter.dart';

import '../model/account.dart';

class BoxRepository {
  static const String boxName ='CRUD';


  static openBox() async => await Hive.openBox<Accounts>(boxName);


  static Box getBox() => Hive.box<Accounts>(boxName);


  static closeBox() async => await Hive.box(boxName).close(); 

}