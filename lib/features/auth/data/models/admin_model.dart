class AdminModel {
  final int id;
  final int userId;
  final int regionId;
  final String? jobTitle;
  final String? avatar;
  final bool isSuperAdmin;

  AdminModel({
    required this.id,
    required this.userId,
    required this.regionId,
    this.jobTitle,
    this.avatar,
    required this.isSuperAdmin,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    id: json['id'],
    userId: json['user_id'],
    regionId: json['region_id'],
    jobTitle: json['job_title'],
    avatar: json['avatar'],
    isSuperAdmin: json['is_super_admin'] == 1,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'region_id': regionId,
    'job_title': jobTitle,
    'avatar': avatar,
    'is_super_admin': isSuperAdmin ? 1 : 0,
  };
}
