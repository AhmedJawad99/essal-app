class UserModel {
  final int id;
  final String name;
  final String email;
  final String? password;
  final String phone;
  final String role;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    phone: json['phone'],
    role: json['role'],
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
    'role': role,
    'created_at': createdAt.toIso8601String(),
  };
}
