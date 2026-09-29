import 'package:dio/dio.dart';
import 'package:essal_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // 1. ترتيب الأكواد المخصصة في البداية
    if (statusCode == 401) {
      return ApiError(
        message: 'Your email or password is incorrect',
        statusCode: statusCode,
      );
    }

    if (statusCode == 403) {
      return ApiError(
        message: 'You dont have permission',
        statusCode: statusCode,
      );
    }

    if (statusCode == 400) {
      return ApiError(message: 'Bad Request', statusCode: statusCode);
    }

    if (statusCode == 404) {
      return ApiError(
        message: 'The Requested URL was not found',
        statusCode: statusCode,
      );
    }

    if (statusCode == 422) {
      return ApiError(
        message: 'The email address is already taken.',
        statusCode: statusCode,
      );
    }

    if (statusCode == 429) {
      return ApiError(
        message: 'Too many requests. Please wait a moment and try again',
        statusCode: statusCode,
      );
    }

    if (statusCode == 500) {
      return ApiError(message: 'Internal Server Error', statusCode: statusCode);
    }

    // 2. إذا لم يكن أي كود من الأكواد السابقة وكان هناك رسالة من الباك اند
    if (statusCode != 200 && statusCode != null) {
      if (data is Map<String, dynamic> && data['message'] != null) {
        return ApiError(message: data['message'], statusCode: statusCode);
      }
    }

    // 3. أخطاء الإنترنت والـ Timeout
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout. Please try again");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Response timeout. Please try again");
      case DioExceptionType.connectionError:
        return ApiError(message: "No internet connection. Please try again");
      default:
        return ApiError(
          message: "An unexpected error occurred. Please try again",
        );
    }
  }
}
