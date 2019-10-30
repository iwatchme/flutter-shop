import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

Future<String> request(String url, {formData}) async {
  try {
    Response response;
    Dio _dio = Dio();
    _dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    _dio.options.connectTimeout = 7 * 1000;
    _dio.options.receiveTimeout = 7 * 1000;
    _dio.interceptors.add(LogInterceptor(responseBody: true));

    if (formData != null) {
      response = await _dio.post(url, data: formData);
    } else {
      response = await _dio.post(url);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("后端接口出现异常");
    }
  } catch (e) {
    return null;
  }
}
