import os

def create_flutter_structure():
    # الأكواد الخاصة بالملفات
    app_colors_code = """import 'dart:ui';

class AppColors {
  static Color primary = Color(0xff103e34);
}
"""

    api_error_code = """class ApiError {
  final String message;
  final int? statusCode;

  ApiError({required this.message ,this.statusCode });

  @override
  String toString() {
    return message;
  }
}
"""

    api_exceptions_code = """import 'package:dio/dio.dart';
import 'package:huungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (statusCode != null) {
      if (data is Map<String, dynamic> && data['message'] != null) {
        return ApiError(message: data['message'], statusCode: statusCode);
      }
    }

    if (statusCode == 302) {
      throw ApiError(message: 'This Email Already Taken');
    }

    if (statusCode == 429) {
      return ApiError(
        message: 'Too many requests. Please wait a moment and try again',
        statusCode: statusCode,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout. Please try again");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response timeout. Please try again");
      default:
        return ApiError(
          message: "An unexpected error occurred. Please try again",
        );
    }
  }
}

// if(statusCode == 302) {
//   return ApiError(message: 'The Email is Already Taken');
// }

// print('Error response: ${error.response?.data}');
// print('Status code: $statusCode');
"""

    api_service_code = """import 'package:dio/dio.dart';
import 'package:huungry/core/network/api_exceptions.dart';
import 'package:huungry/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// CRUD METHODS

  /// get
  Future<dynamic> get(String endPoint , {dynamic param}) async {
    try {
      final response = await _dioClient.dio.get(endPoint, queryParameters: param);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// post
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// put || update
  Future<dynamic> put(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// delete
  Future<dynamic> delete(String endPoint, dynamic body, {dynamic params}) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body , queryParameters: params);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}
"""

    dio_client_code = """import 'package:dio/dio.dart';
import 'package:huungry/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api/',
      headers: {"Content-Type": 'application/json'},
    ),
  );

  DioClient() {
    // _dio.interceptors.add(
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          } else {}
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
"""

    pref_helper_code = """import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {

  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    final  prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final  prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final  prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
  }
}
"""

    # قاموس يحتوي على مسارات الملفات كمفاتيح ومحتواها كقيم
    files_to_create = {
        "core/constants/api_endpoints.dart": "",
        "core/constants/app_colors.dart": app_colors_code,
        "core/network/api_error.dart": api_error_code,
        "core/network/api_exceptions.dart": api_exceptions_code,
        "core/network/api_service.dart": api_service_code,
        "core/network/dio_client.dart": dio_client_code,
        "core/utils/pref_helper.dart": pref_helper_code,
        "core/utils/validators.dart": "",
    }

    # قائمة المجلدات الفارغة الإضافية
    empty_directories = [
        "features/auth",
        "features/home",
        "shared"
    ]

    # إنشاء المجلدات والملفات
    for file_path, content in files_to_create.items():
        # إنشاء المجلد إذا لم يكن موجوداً
        os.makedirs(os.path.dirname(file_path), exist_ok=True)
        # كتابة المحتوى داخل الملف
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(content)
            
    # إنشاء المجلدات الفارغة
    for directory in empty_directories:
        os.makedirs(directory, exist_ok=True)

    print("تم إنشاء هيكل المجلدات والملفات بنجاح! ✅")

if __name__ == "__main__":
    create_flutter_structure()