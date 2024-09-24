import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:streetwise/models/post.dart';
import 'package:streetwise/services/api_service/api_base_helper.dart';
import 'package:streetwise/services/api_service/dio_exception.dart';
import 'package:streetwise/services/api_service/end_points.dart';

class PostRepository {
  late Dio _dio;
  static final PostRepository _singleton = PostRepository._internal();

  factory PostRepository() {
    return _singleton;
  }

  PostRepository._internal() {
    _dio = ApiBaseHelper().dio;
  }

  void _log(String msg, {String? name, Object? error}) {
    log(msg, name: "PostRepository -> $name", error: error);
  }

  Future<List<Post>> getPost({required String token}) async {
    try {
      Map<String, String> data = {
        'token': token,
      };
      final response =
          await _dio.post(Endpoints.post, data: token == "" ? null : data);

      if (response.statusCode == 200) {
        final List<Post> postList = (response.data['data'])
            .map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
        return postList;
      } else {
        throw response.data.toString();
      }
    } on DioException catch (e) {
      _log("", error: e, name: "getPost");
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      _log("", error: e, name: "getPost");
      throw e.toString();
    }
  }

//How to call the API
// late PostRepository _postrRepository;
// Future<List<Post>> getPostData() async {
//     return await _postrRepository.getPost(token:"xtdhsfhsdf");
// }
}
