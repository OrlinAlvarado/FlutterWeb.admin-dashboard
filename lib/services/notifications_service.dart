import 'package:flutter/material.dart';

class NotificationsService {
  
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackbarError( String message){
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(message, style: TextStyle(color: Colors.white),),
    );
    
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}