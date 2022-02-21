import 'package:flutter/material.dart';
import 'package:admin_dashboard/api/CafeApi.dart';

import 'package:admin_dashboard/models/usuario.dart';
import 'package:admin_dashboard/models/http/users_response.dart';


class UsersProvider extends ChangeNotifier {
    List<Usuario> usuarios = [];
    bool isLoading = true;
    bool ascending = true;
    int? sortColumnIndex;
    
    UsersProvider(){
      getPaginatedUsers();
    }
    
    getPaginatedUsers() async{
      final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
      final usersResp = UsersResponse.fromMap(resp);
      usuarios = [...usersResp.usuarios];
      
      isLoading = false;
      notifyListeners();
    }
    Future<Usuario?> getUserById( String uid ) async{
      try {
        final resp = await CafeApi.httpGet('/usuarios/$uid');
        final user = Usuario.fromMap(resp);
        return user;
      } catch (e) {
        return null;
      }
    }
    
    void sort<T>( Comparable<T> Function( Usuario user) getField ){
      usuarios.sort((a,b) {
        final aValue = getField( a );
        final bValue = getField( b );
        
        return ascending 
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue,aValue);
      });
      
      ascending = !ascending;
      notifyListeners();
    }
    
    Future newUser( String name) async {
      final data = {
        'nombre': name
      };
      
      try {
        final json = await CafeApi.post('/usuarios', data);
        final newUser = Usuario.fromMap(json);
        usuarios.add(newUser);
        notifyListeners();
      } catch (e) {
        throw 'Error al crear usuario';
      }
    }
    Future updateUser( String id, String name) async {
      // final data = {
      //   'nombre': name
      // };
      
      try {
        //final json = await CafeApi.put('/categorias/$id', data);
        //Si se recibiera el mismo objeto se puede hacer de esta forma
        //final updatedCategory = Categoria.fromMap(json);
        //categorias = [ ...categorias.where((element) => element.id != id), updatedCategory ];
        
        usuarios = usuarios.map((usuario) {
          if(usuario.uid != id) return usuario;
          
          usuario.nombre = name;
          return usuario;
          
        }).toList();
        
        notifyListeners();
      } catch (e) {
        throw 'Error al actualizar usuario';
      }
    }
    Future deleteUser( String uid) async {
      
      try {
        await CafeApi.delete('/usuarios/$uid', {});
        //categorias = [ ...categorias.where((element) => element.id != id)];
        usuarios.removeWhere((usuario) => usuario.uid == uid);
        notifyListeners();
      } catch (e) {
        print(e);
        print('Error al crear usuario');
      }
    }
    
    void refreshUser( Usuario newUser){
     usuarios = usuarios.map((user){
       if(user.uid == newUser.uid){
         return newUser;
       } else {
         return user;
       }
     }).toList();
      
      notifyListeners();
    }
}