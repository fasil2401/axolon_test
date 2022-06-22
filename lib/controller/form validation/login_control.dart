import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginFormControl extends GetxController{
    var emailControl = '';
  var passwordControl = '';
 var email = false.obs;
  var password = false.obs;

  validateEmailorphone(String value) {
      // emailControl = value;
      if (!GetUtils.isEmail(value)) {
      email.value = true;
    } else {
      email.value = false;
      emailControl = value;
    }
  }
  validatePassword(String value) {
      // passwordControl = value;
       if (value.length != 10) {
      password.value = true;
    } else {
      password.value = false;
      passwordControl = value;
    }
  }

  checkLoginForm() {
    if (
        email.value == false &&
        password.value == false &&
        
        emailControl.isNotEmpty &&
        passwordControl.isNotEmpty) {
      // Get.toNamed('/verification');
      // registerApiControl.getRegisterOtp(
      //     name: nameControl, email: emailControl, phone: phoneControl);
      Get.toNamed('/home');
    } else {
      Get.snackbar('Warning!', 'Please complete the form', snackPosition: SnackPosition.BOTTOM);
    }
  }
}