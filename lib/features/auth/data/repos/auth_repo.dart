import 'package:dio/dio.dart';
import 'package:essal_app/core/network/api_error.dart';
import 'package:essal_app/core/network/api_exceptions.dart';
import 'package:essal_app/core/network/api_service.dart';
import 'package:essal_app/features/auth/data/models/user_model.dart';
import 'dart:convert';

class AuthRepo {
  //Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await ApiService().post('/login', {
        "email": email,
        "password": password,
      });

      // print('=== Debug Info ===');
      // print('Response Type: ${response.runtimeType}');
      // print('Response Value: $response');
      // print('==================');

      if (response is ApiError) {
        throw response;
      }

      Map<String, dynamic>? responseData;

      if (response is Response) {
        if (response.data is Map<String, dynamic>) {
          responseData = response.data;
        } else if (response.data is String) {
          responseData = jsonDecode(response.data);
        }
      } else if (response is Map<String, dynamic>) {
        responseData = response;
      } else if (response is String) {
        responseData = jsonDecode(response);
      }

      if (responseData != null) {
        final msg = responseData['message'];
        final code = responseData['code'];
        final data = responseData['data'];

        if (code == 200 || code == null) {
          if (data == null) return null;

          try {
            final user = UserModel.fromJson(data);
            return user;
          } catch (parseError) {
            throw ApiError(message: 'Failed to parse user data: $parseError');
          }
        } else {
          throw ApiError(
            message: msg ?? 'Failed to parse user data',
            statusCode: code,
          );
        }
      }

      throw ApiError(
        message: 'Unsupported data format: ${response.runtimeType}',
      );
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) {
        throw e;
      }
      throw ApiError(message: '${e.toString()}');
    }
  }

  //register
  Future<UserModel?> register(
    String name,
    String email,
    String phone,
    String password,
    String role,
  ) async {
    try {
      final response = await ApiService().post('/register', {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "role": role,
      });

      if (response is ApiError) {
        throw response;
      }

      Map<String, dynamic>? responseData;

      if (response is Response) {
        if (response.data is Map<String, dynamic>) {
          responseData = response.data;
        } else if (response.data is String) {
          responseData = jsonDecode(response.data);
        }
      } else if (response is Map<String, dynamic>) {
        responseData = response;
      } else if (response is String) {
        responseData = jsonDecode(response);
      }

      if (responseData != null) {
        final msg = responseData['message'];
        final code = responseData['code'];
        final data = responseData['data'];

        if (code == 200 || code == null) {
          if (data == null) return null;

          try {
            final user = UserModel.fromJson(data);
            return user;
          } catch (parseError) {
            throw ApiError(message: 'Failed to parse user data: $parseError');
          }
        } else {
          throw ApiError(
            message: msg ?? 'Failed to parse user data',
            statusCode: code,
          );
        }
      }

      throw ApiError(
        message: 'Unsupported data format: ${response.runtimeType}',
      );
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      if (e is ApiError) {
        throw e;
      }
      throw ApiError(message: '${e.toString()}');
    }
  }
}
