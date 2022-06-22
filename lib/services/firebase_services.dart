import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interview_axolon/model/firebase_model.dart';


class Services {

   
  Future createAccount(Acccount user) async {
    final docUser = FirebaseFirestore.instance.collection('accounts').doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }
  // Future updateNote(Acccount user, String id) async {
  //   final docUser = FirebaseFirestore.instance.collection(emailController.email.value).doc(id);
  //   user.id = id;
  //   final json = user.toJson();
  //   await docUser.update(json);
  // }
}
