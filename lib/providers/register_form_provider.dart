import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier{
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  
  bool validateForm(){
    if(formKey.currentState!.validate())
    {
      // print('Form valid... Login');
      return true;
    } else {
      // print('Form no valid');
      return false;
    }
  }
}