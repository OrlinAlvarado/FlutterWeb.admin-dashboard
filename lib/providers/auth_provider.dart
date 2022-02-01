
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier{
  
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  
  AuthProvider(){
    this.isAuthenticated();
  }
  
  
  login(String email, String password){
    //TODO: Peticion HTTP
    _token = 'adjkfhadadfjkasdfkjklhakljsdf';
    LocalStorage.prefs.setString('token', _token!);
    print('Almacenar JWT: $_token');
    
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    NavigationService.replaceTo(Fluroruter.dashboardRoute);
  }
  
  Future<bool> isAuthenticated() async{
    final token = LocalStorage.prefs.getString('token');
    if(token == null){
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    
    //TODO: Ir al backend y comprbar si el JWT es valido
    
    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}