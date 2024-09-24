import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetClass;
import 'package:streetwise/routes/routes_name.dart';


class DioInterceptor extends Interceptor {
  DioInterceptor() : super();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path} => DATA : ${response.data}',
        name: 'DioInterceptor - onResponse');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print(err.toString() + 'The error of the onError');
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
        name: 'DioInterceptor - onError');
    log("ERROR[${err.response?.statusCode}] => response:${err.response}");
    log("ERROR[${err.response?.statusCode}] => err:$err");
    await handleUnAuthorized(statusCode: err.response?.statusCode ?? 0);
    return super.onError(err, handler);
  }

  Uri getUri(String endpoint, {Map<String, String>? params}) {
    Uri uri = Uri.parse(endpoint);
    if (params != null) uri = uri.replace(queryParameters: params);
    return uri;
  }

  void debugPrintPreRequest({url, data, headers}) {
    log("url : $url \n data : $data \n headers : $headers ",
        name: 'DioInterceptor - debugPrintPreRequest');
  }

  bool isValidResponse(int statusCode, {int responseStatus = 1}) {
    return statusCode >= 200 && statusCode <= 302 && responseStatus == 1;
  }

  Future<void> handleUnAuthorized({required int statusCode}) async {
    if (statusCode >= 400 &&
        statusCode <= 403 &&
        GetClass.Get.currentRoute != RoutesName.sample) {
      // await GetClass.Get.offAllNamed(RoutesName.login);
    }
  }
}
