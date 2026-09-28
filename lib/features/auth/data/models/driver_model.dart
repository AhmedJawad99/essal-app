class DriverModel {
  final int id;
  final int userId;
  final String vehicleType;
  final String plateNumber;
  final double walletBalance;
  final String? currentLat;
  final String? currentLng;

  DriverModel({
    required this.id,
    required this.userId,
    required this.vehicleType,
    required this.plateNumber,
    required this.walletBalance,
    this.currentLat,
    this.currentLng,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    id: json['id'],
    userId: json['user_id'],
    vehicleType: json['vehicle_type'],
    plateNumber: json['plate_number'],
    walletBalance: json['wallet_balance'],
    currentLat: json['current_lat'],
    currentLng: json['current_lng'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'vehicle_type': vehicleType,
    'plate_number': plateNumber,
    'wallet_balance': walletBalance,
    'current_lat': currentLat,
    'current_lng': currentLng,
  };
}
