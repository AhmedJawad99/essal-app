import 'package:essal_app/core/network/api_error.dart';
import 'package:essal_app/core/network/api_service.dart';
import 'package:essal_app/features/auth/data/models/user_model.dart';

class AuthRepo {
  //Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await ApiService().post('/login', {
        "email": email,
        "password": password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        print('done');
      }
    } catch (e) {}
  }
}
