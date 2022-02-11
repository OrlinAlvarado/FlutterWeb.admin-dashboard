import 'package:flutter/material.dart';
import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';


class CategoriesProvider extends ChangeNotifier {
    List<Categoria> categorias = [];
    
    getCategories() async{
      final resp = await CafeApi.httpGet('/categorias');
      final categoriesResp = CategoriesResponse.fromMap(resp);
      categorias = [...categoriesResp.categorias];
      notifyListeners();
    }
    
    Future newCategory( String name) async {
      final data = {
        'nombre': name
      };
      
      try {
        final json = await CafeApi.post('/categorias', data);
        final newCategory = Categoria.fromMap(json);
        categorias.add(newCategory);
        notifyListeners();
      } catch (e) {
        throw 'Error al crear categoria';
      }
    }
    Future updateCategory( String id, String name) async {
      // final data = {
      //   'nombre': name
      // };
      
      try {
        //final json = await CafeApi.put('/categorias/$id', data);
        //Si se recibiera el mismo objeto se puede hacer de esta forma
        //final updatedCategory = Categoria.fromMap(json);
        //categorias = [ ...categorias.where((element) => element.id != id), updatedCategory ];
        
        categorias = categorias.map((category) {
          if(category.id != id) return category;
          
          category.nombre = name;
          return category;
          
        }).toList();
        
        notifyListeners();
      } catch (e) {
        throw 'Error al actualizar categoria';
      }
    }
    Future deleteCategory( String id) async {
      
      try {
        await CafeApi.delete('/categorias/$id', {});
        //categorias = [ ...categorias.where((element) => element.id != id)];
        categorias.removeWhere((categoria) => categoria.id == id);
        notifyListeners();
      } catch (e) {
        print(e);
        print('Error al crear categoria');
      }
    }
}