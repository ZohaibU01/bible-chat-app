import 'dart:io';

import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    // Configure Dio instance
    _dio.options = BaseOptions(
      baseUrl: Constants.API_HOST,
      // baseUrl: "http://192.168.20.248:5000/api",

      // Replace with your base URL
      connectTimeout: const Duration(minutes: 10),
      receiveTimeout: const Duration(minutes: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // Add interceptors for logging
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("\n[API Request]");
        print("Endpoint: ${options.baseUrl}${options.path}");
        print("Method: ${options.method}");
        print("Headers: ${options.headers}");
        print("Request Data: ${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        print("\n[API Response]");
        print("Status Code: ${response.statusCode}");
        print("Data: ${response.data}");
        handler.next(response);
      },
      onError: (DioError error, handler) {
        print("\n[API Error]");
        print("Message: ${error.message}");
        print("Status Code: ${error.response?.statusCode}");
        print("Error Data: ${error.response?.data}");
        if (error.response != null) {}
        handler.next(error);
      },
    ));
  }

  Future<Response?> putRequestWithFormData(String endpoint,
      {Map<String, dynamic> data = const {}, String? filePath}) async {
    try {
      print("\n[API PUT Request with FormData]");
      print("Endpoint: $endpoint");
      print("Request Data: $data");

      // If filePath is provided, add the file to FormData
      FormData formData = FormData.fromMap(data);

      if (filePath != null && filePath.isNotEmpty) {
        formData.files.add(MapEntry(
          'file', // Use the correct field name for your backend
          await MultipartFile.fromFile(filePath, filename: 'profile_picture'),
        ));
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${DataStroge.userToken.value}'
      };

      // Send PUT request with FormData
      final response = await _dio.put(endpoint,
          data: formData, options: Options(headers: headers, method: "PUT"));

      return response;
    } catch (error) {
      print("Error in PUT Request with FormData: $error");
      return null;
    }
  }

  Future<Response?> putRequest(String endpoint,
      {Map<String, dynamic> data = const {},
      Map<String, dynamic>? headers}) async {
    try {
      print("\n[API PUT Request]");
      print("Endpoint: $endpoint");
      print("Request Data: $data");

      // Add custom headers if provided
      final response = await _dio.put(endpoint,
          data: data, options: Options(headers: headers));

      return response;
    } catch (error) {
      print("Error in PUT Request: $error");
      return null;
    }
  }

  Future<Response?> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(endpoint,
          queryParameters: queryParams, options: Options(headers: headers));
      return response;
    } catch (error) {
      print("Error in GET Request: \$error");
      return null;
    }
  }

  Future<Response?> postRequest(String endpoint,
      {Map<String, dynamic> data = const {}}) async {
    try {
      print("\n[API POST Request]");
      print("Endpoint: $endpoint");
      // FormData formData = FormData.fromMap(data); // Using FormData for form-data requests
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (error) {
      print("Error in POST Request: $error");
      return null;
    }
  }

  Future<Response?> postRequestWithToken(
      String endpoint, Map<String, dynamic> data) async {
    try {
      print("\n[API POST Request]");
      print("Endpoint: $endpoint");

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${DataStroge.userToken.value}'
      };

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: headers,
          method: 'POST',
        ),
      );

      return response;
    } catch (error) {
      print("Error in POST Request: $error");
      return null;
    }
  }

  Future<Response?> deleteRequest(String endpoint, Map<String, dynamic> data,
      {Map<String, String>? headers}) async {
    try {
      print("\n[API GET Request]");
      print("Endpoint: ${_dio.options.baseUrl}$endpoint");

      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }
      final response = await _dio.delete(
        endpoint,
        data: data,
      );
      return response;
    } catch (e) {
      print("Error in DELETE request: $e");
      return null;
    }
  }

  Future<Response?> getRequestWithToken(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      print("\n[API GET Request]");
      print("Endpoint: ${_dio.options.baseUrl}$endpoint");

      if (headers != null) {
        _dio.options.headers.addAll(headers);
      }

      final response = await _dio.get(endpoint);
      return response;
    } catch (error) {
      print("Error in GET Request: $error");
      return null;
    }
  }
}
