import 'package:admin_dashboard/models/http/auth_response.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/CafeApi.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier{
  
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;
  
  AuthProvider(){
    isAuthenticated();
  }
  
  
  login(String email, String password){
    final data = {
      'correo': email,
      'password': password,
    };
    
    
    CafeApi.post('/auth/login', data)
    .then(validateLogin)
    .catchError((e) {
      print('error en: $e');
      NotificationsService.showSnackbarError('Credenciales no válidas');
    });
  }
  
  register(String email, String password, String name){
    
    final data = {
      'nombre': name,
      'correo': email,
      'password': password,
    };
    
    
    CafeApi.post('/usuarios', data)
      .then(validateLogin)
      .catchError((e) {
        print('error en: $e');
        NotificationsService.showSnackbarError('Credenciales no válidas');
      });
    
  }
  
  validateLogin( dynamic json, { bool redirect = true }){
    final authResponse = AuthResponse.fromMap(json);
    user = authResponse.usuario;
    
    authStatus = AuthStatus.authenticated;
    LocalStorage.prefs.setString('token', authResponse.token);
    if(redirect){
      NavigationService.replaceTo(Fluroruter.dashboardRoute);
    }
    CafeApi.configureDio();
    notifyListeners();
  }
  
  logout(){
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
  
  Future<bool> isAuthenticated() async{
    final token = LocalStorage.prefs.getString('token');
    if(token == null){
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    
    try {
      final json = await CafeApi.httpGet('/auth');
      validateLogin(json, redirect: false);
      return true;
      
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }
}