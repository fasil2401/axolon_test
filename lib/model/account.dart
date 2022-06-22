import 'package:hive_flutter/hive_flutter.dart';
part 'account.g.dart';

@HiveType(typeId: 0)
class Accounts {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? note;
  @HiveField(2)
  final dynamic imagePath;

  Accounts({this.title, this.note, this.imagePath,});
}
