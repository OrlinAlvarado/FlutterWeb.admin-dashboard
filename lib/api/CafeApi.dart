import 'dart:typed_data';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static final Dio _dio = Dio();
  
  static void configureDio(){
    //Base del url
    //_dio.options.baseUrl = 'http://localhost:8080/api';
    _dio.options.baseUrl = 'https://hn-flutter-web-admin.herokuapp.com/api';
    
    //Configurar Headers
    
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }
  
  
  static Future httpGet(String path) async {
    try {
      final response = await _dio.get(path);
      
      return response.data;
      
    } on DioError catch (e) {
      print(e.response);
      throw('Error en el GET');
    }
  }
  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.post(path, data: formData );
      
      return response.data;
      
    } on DioError catch (e) {
      print(e);
      throw('Error en el POST');
    }
  }
  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.put(path, data: formData );
      
      return response.data;
      
    } on DioError catch (e) {
      print(e);
      throw('Error en el POST,$e');
    }
  }
  
  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.delete(path, data: formData);
      
      return true;
      
    } on DioError catch (e) {
      print(e);
      throw('Error en el POST');
    }
  }
  
    static Future uploadFile(String path, Uint8List bytes) async {
    final formData = FormData.fromMap({
      'archivo': MultipartFile.fromBytes(bytes)
    });
    
    try {
      final response = await _dio.put(path, data: formData );
      
      return response.data;
      
    } on DioError catch (e) {
      print(e);
      throw('Error en el POST,$e');
    }
  }
  
}