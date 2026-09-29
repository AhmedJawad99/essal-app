import 'package:essal_app/features/auth/data/models/admin_model.dart';
import 'package:essal_app/features/auth/data/models/driver_model.dart';
import 'package:essal_app/features/auth/data/models/merchant_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? password;
  final String phone;
  final String role;
  final MerchantModel? merchant_profile;
  final DriverModel? driver_profile;
  final AdminModel? admin_profile;
  final DateTime? createdAt; // جعلناه يقبل null لحماية التطبيق من الانهيار
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    required this.role,
    this.merchant_profile,
    this.driver_profile,
    this.admin_profile,
    this.createdAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] ?? json;

    return UserModel(
      id: userJson['id'] ?? 0,
      name: userJson['name'] ?? '',
      email: userJson['email'] ?? '',
      password: userJson['password'],
      phone: userJson['phone']?.toString() ?? '',
      role: userJson['role'] ?? '',
      merchant_profile: userJson['merchant_profile'] == null
          ? null
          : MerchantModel.fromJson(userJson['merchant_profile']),
      driver_profile: userJson['driver_profile'] == null
          ? null
          : DriverModel.fromJson(userJson['driver_profile']),
      admin_profile: userJson['admin_profile'] == null
          ? null
          : AdminModel.fromJson(userJson['admin_profile']),

      createdAt: userJson['created_at'] != null
          ? DateTime.tryParse(userJson['created_at'])
          : null,

      token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
    'role': role,
    'merchant_profile': merchant_profile?.toJson(),
    'driver_profile': driver_profile?.toJson(),
    'admin_profile': admin_profile?.toJson(),
    'created_at': createdAt?.toIso8601String(),
    'access_token': token,
  };
}
