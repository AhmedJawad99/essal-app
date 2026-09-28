import 'package:dio/dio.dart';
import '../utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.164:8000/api/',
      headers: {"Content-Type": 'application/json'},
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );

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
