
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Repository/box_repository.dart';
import '../model/account.dart';

class AccountsController extends GetxController {
  
  final Box observableBox = BoxRepository.getBox();

  // Box get observableBox => _observableBox;

  // int get notesCount => _observableBox.length;

  createAccount({required Accounts account}){
    observableBox.add(account);
    update();
  }
  updateAccount({required int index, required Accounts note}){
    observableBox.putAt(index, note);
    update();
  }

  deleteAccount({required int index}){
    observableBox.deleteAt(index);
    update();
  }
}