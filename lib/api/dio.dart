import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/token_shared_pref.dart';
import 'package:lca/model/complaint/complaint_count_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DioMethod { post, get, put, delete }

class APIService {
  APIService._singleton();

  static final APIService instance = APIService._singleton();

  String get baseUrl => url;

  Future<ComplaintCount> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    dynamic formData,
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: "application/json",
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ2YWxpZEFzT2YiOjE3MjEwNDY0MDYsInN1YiI6ImN1c3RvbWVyMUBjb21wYW55LmNvbSIsImlzcyI6ImF1dG9tYXQtaXJyaWdhdGlvbi1wbGF0Zm9ybSIsImlhdCI6MTcyMTUzODQxNSwiZXhwIjoxNzI5MzE0NDE1fQ.Nf8DKtWNwxjVyXeIvKiL28KgwtnoWMjXIejesS_l7MkSEWtc_f6zW07_4ZJxLx2Mi8KSgL3HmId-nHTgQ4G14Q',
          },
        ),
      );

      Response response;

      switch (method) {
        case DioMethod.post:
          response = await dio.post(
            endpoint,
            data: formData ?? param,
          );
          break;
        case DioMethod.get:
          response = await dio.get(
            endpoint,
          
          );
          break;
        case DioMethod.put:
          response = await dio.put(
            endpoint,
            data: formData ?? param,
          );
          break;
        case DioMethod.delete:
          response = await dio.delete(
            endpoint,
            data: formData ?? param,
          );
          break;
        default:
          response = await dio.post(
            endpoint,
            data: formData ?? param,
          );
      }

      return ComplaintCount.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        // Handle Dio-specific errors here
        throw Exception('Dio error: ${e.message}');
      } else {
        throw Exception('Network error: $e');
      }
    }
  }
}
