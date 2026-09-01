class Shop {
  final int id;
  final String name;
  final String phone;
  final double latitude;
  final double longitude;
  final String? address;
  final String? landmark;
  final double distanceInMeters;

  Shop({
    required this.id,
    required this.name,
    required this.phone,
    required this.latitude,
    required this.longitude,
    this.address,
    this.landmark,
    required this.distanceInMeters,
  });

  factory Shop.fromMap(Map<String, dynamic> map, double distanceInMeters) {
    return Shop(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      landmark: map['landmark'],
      distanceInMeters: distanceInMeters,
    );
  }
}
