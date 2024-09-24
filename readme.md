# Post Repository Example
1. Add Dio and other necessary packages to your `pubspec.yaml`:
    dependencies:
      dio: ^5.0.0

2. Install the packages by running:
    flutter pub get

## Usage API Service - Dio Integration
 --------------------------------------
## Key Features
1. Dio integration for handling HTTP requests.
2. Singleton pattern for the API service to ensure a single instance.
3. Interceptor for logging requests, responses, and managing errors.
4. Custom error handling with specific error messages for different scenarios (timeouts, unauthorized, etc.).
5. Timeout settings for request and response handling.
6. Token-based authentication support.

import 'package:dio/dio.dart';

## Setup Steps:
1. Add Dio to pubspec.yaml.
2. Install dependencies using `flutter pub get`.
3. Setup Dio with base options and attach the interceptor for handling common API behavior.

##  Example Singleton Class (ApiBaseHelper):
class ApiBaseHelper {
   Singleton pattern to ensure only one instance of Dio is created
  late Dio dio;
  static final ApiBaseHelper _instance = ApiBaseHelper._internal();

   ## Internal constructor
  ApiBaseHelper._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://example.com/api',   Your API base URL
      connectTimeout: 25000,
      receiveTimeout: 25000,
    ));

     Attach interceptor
    dio.interceptors.add(DioInterceptor());
  }

   ## Factory constructor returns the singleton instance
  factory ApiBaseHelper() {
    return _instance;
  }
}

 ## Key Components:
 1. ApiBaseHelper: 
    - Singleton class responsible for initializing Dio with default configurations.
    - Configures timeout settings and attaches the interceptor.

 2. DioInterceptor:
    - Logs request details, responses, and error statuses.
    - Handles unauthorized access logic and redirects.

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
     Logging request details
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
     Logging response details
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
     Logging error details and handling unauthorized responses
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

 3. DioExceptions:
    - Custom exception class to handle Dio-specific errors.
    - Maps different error types (e.g., connection timeout, server errors) to user-friendly messages.

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        message = "Connection timeout with server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with server";
        break;
      case DioErrorType.response:
        message = _handleError(dioError.response?.statusCode);
        break;
      default:
        message = "Unexpected error occurred";
        break;
    }
  }

  String _handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

 ## Usage:
 1. Initialize the ApiBaseHelper and use Dio to make network requests.
 2. Handle API responses and errors with built-in mechanisms.

void main() {
   Example usage of ApiBaseHelper to make a GET request
  final apiHelper = ApiBaseHelper();
  apiHelper.dio.get('/posts').then((response) {
    print(response.data);   Handle successful response
  }).catchError((error) {
    if (error is DioError) {
       Handle Dio error using the custom DioExceptions class
      final dioError = DioExceptions.fromDioError(error);
      print(dioError.toString());
    }
  });
}

##  Error Handling:
 1. Use DioExceptions for catching and displaying API error messages.
 2. Implement logic to handle unauthorized errors and trigger appropriate actions (e.g., user redirection).

 ## Notes:
 - Adjust timeout settings as required.
 - Extend interceptor logic for custom behavior (like logging, retry logic, etc.).
 - This structure is scalable and can be easily extended for more API services and error handling.

