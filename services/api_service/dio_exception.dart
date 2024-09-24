import 'package:dio/dio.dart';
import 'package:streetwise/constants/strings_constant.dart';


class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Unable to communicate with the server. Please try again.";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with the server. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        message =
            "Receive timeout in connection with the server. Please try again.";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message =
            "Send timeout in connection with the server. Please try again.";
        break;
      case DioExceptionType.connectionError:
        message = StringConst.cannotConnected;
        break;
      case DioExceptionType.unknown:
        message = "Unexpected error occurred. Please try again.";
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate.';
        break;
      default:
        message = "Something went wrong. Please try again.";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message']; //'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
