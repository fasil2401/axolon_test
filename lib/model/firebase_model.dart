import 'package:cloud_firestore/cloud_firestore.dart';

class Acccount {
  String id;
  final String name;
  final int roll;
  final dynamic imagePath;
  final bool isFirebase;

  Acccount({
    this.id = '',
    required this.name,
    required this.roll,
    required this.isFirebase,
   required this.imagePath
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'roll': roll, 'isFirebase': isFirebase, 'imagePath': imagePath};
  }

  Acccount.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc['id'],
        name = doc['name'],
        roll = doc['roll'],
        imagePath = doc['imagePath'],
        isFirebase = doc['isFirebase'];
}
