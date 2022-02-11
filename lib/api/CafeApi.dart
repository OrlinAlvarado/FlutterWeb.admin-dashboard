import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static final Dio _dio = Dio();
  
  static void configureDio(){
    //Base del url
    _dio.options.baseUrl = 'http://localhost:8080/api';
    
    //Configurar Headers
    
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }
  
  
  static Future httpGet(String path) async {
    try {
      final response = await _dio.get(path);
      
      return response.data;
      
    } catch (e) {
      print(e);
      throw('Error en el GET');
    }
  }
  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.post(path, data: formData );
      
      return response.data;
      
    } catch (e) {
      print(e);
      throw('Error en el POST');
    }
  }
  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.put(path, data: formData );
      
      return response.data;
      
    } catch (e) {
      print(e);
      throw('Error en el POST');
    }
  }
  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.delete(path, data: formData);
      
      return true;
      
    } catch (e) {
      print(e);
      throw('Error en el POST');
    }
  }
}