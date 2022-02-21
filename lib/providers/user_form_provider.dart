import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/models/usuario.dart';

class UserFormProvider extends ChangeNotifier{
  Usuario? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // void updateListeners(){
  //   notifyListeners();
  // }
  
  bool _validForm(){
    return formKey.currentState!.validate();
  }
  
  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }){
    user = Usuario(
      rol: rol ?? user!.rol,
      estado: estado ?? user!.estado,
      google: google ?? user!.google,
      nombre: nombre ?? user!.nombre,
      correo: correo ?? user!.correo,
      uid: uid ?? user!.uid,
      img: img ?? user!.img,
    );
    
    notifyListeners();
  }
  
  updateUser() async{
    if( !_validForm()) return false;
    
    final data = {
      'nombre': user!.nombre,
      'correo': user!.correo,
    };
    
    try {
      final resp = await CafeApi.put('/usuarios/${ user!.uid }', data);
      
      print(resp);
      return true;
    } catch (e) {
      print('Error en updateUser: $e');
      return false;
    }
  }
  
  
  
}