import 'package:hive_flutter/hive_flutter.dart';
part 'account.g.dart';

@HiveType(typeId: 0)
class Accounts {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final int? roll;
  @HiveField(2)
  final dynamic imagePath;

  Accounts({this.name, this.roll, this.imagePath,});
}
