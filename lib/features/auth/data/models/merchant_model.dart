class MerchantModel {
  final int id;
  final int userId;
  final String storeName;
  final String? storeAddress;
  final String? gpsLink;

  MerchantModel({
    required this.id,
    required this.userId,
    required this.storeName,
    this.storeAddress,
    this.gpsLink,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) => MerchantModel(
    id: json['id'],
    userId: json['user_id'],
    storeName: json['store_name'],
    storeAddress: json['store_address'],
    gpsLink: json['gps_link'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'store_name': storeName,
    'store_address': storeAddress,
    'gps_link': gpsLink,
  };
}
