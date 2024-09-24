import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:streetwise/services/api_service/dio_Interceptor.dart';
import 'package:streetwise/services/api_service/end_points.dart';


class ApiBaseHelper {
  late Dio dio;

  // connectTimeout
  static const int _receiveTimeout = 25000;
  static const int _connectionTimeout = 25000;

  static final ApiBaseHelper _instance = ApiBaseHelper._internal();
  factory ApiBaseHelper() {
    return _instance;
  }

  ApiBaseHelper._internal() {
    log('ApiBaseHelper._internal()', name: 'ApiBaseHelper');
    dio = Dio(_opts);
    dio.interceptors.add(DioInterceptor());

    log('ApiBaseHelper._internal() dio.interceptors.add(DioInterceptor(null));',
        name: 'ApiBaseHelper');
  }

  final BaseOptions _opts = BaseOptions(
    baseUrl: Endpoints.baseUrl,
    receiveDataWhenStatusError: true,
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: _connectionTimeout),
    receiveTimeout: const Duration(milliseconds: _receiveTimeout),
  );
}
