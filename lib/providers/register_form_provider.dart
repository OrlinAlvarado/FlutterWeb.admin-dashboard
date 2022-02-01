import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier{
  
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  
  validateForm(){
    if(formKey.currentState!.validate())
    {
      print('Form valid... Login');
    } else {
      print('Form no valid');
    }
  }
}