
import 'package:flutter/material.dart';
import 'package:food_order_app/core/common/enum.dart';
import 'package:food_order_app/core/common/validators.dart';
import 'package:food_order_app/core/routes/routes_string.dart';
import 'package:food_order_app/screens/authendication/model/login_response_model.dart';
import 'package:food_order_app/screens/authendication/repository/auth_repository.dart';

class AuthProvider extends AuthRepository with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Validators validator = Validators();
  LoginResponse? loginResponse;

  void login(BuildContext context) async {
    Map body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    loginResponse = await loginAPI(context, body);
    if (loginResponse!.status!) {
      goAndCloseAll(context, AppRoutes.home);
      flushAlert(context, ResponseType.success, "Login Successfully");
      clear();
      notifyListeners();
    }
  }

  void signup(BuildContext context) async {
    Map signupdetails = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirm_password": confirmpasswordController.text,
      "mobile_number": mobileController.text
    };
    await signupAPI(context, signupdetails);
    goAndCloseAll(context, AppRoutes.login);
    flushAlert(context, ResponseType.success, "Signup Successfully");
    clear();
    notifyListeners();
  }

  clear() {
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    nameController.clear();
    mobileController.clear();
  }
}
