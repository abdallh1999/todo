import 'package:dio/dio.dart';

class ApiService {
  // final _baseUrl = 'https://dummyjson.com/';
  final Dio _dio;
  final _baseUrl = Uri.parse('https://dummyjson.com/');

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$_baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, dynamic data}) async {
    var response = await _dio.post('$_baseUrl$endPoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint, dynamic data,required String id}) async {
    var response = await _dio.put('$_baseUrl$endPoint/$id', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> delete(
      {required String endPoint, required String id}) async {
    var response = await _dio.delete('$_baseUrl$endPoint/$id');
    return response.data;
  }
}
