class Asset {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? sensorId;
  Asset({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.sensorId,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      locationId: json['locationId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
      sensorId: json['sensorId'],
    );
  }
}
