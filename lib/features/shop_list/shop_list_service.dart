import 'package:geolocator/geolocator.dart';

import '../../common/models/shop.dart';

List<Shop> getNearbyShops(
  Position userPosition,
  List<Map<String, dynamic>> allShops,
) {
  final shopsWithDistance = allShops.map((map) {
    final distance = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      map['latitude'],
      map['longitude'],
    );
    return Shop.fromMap(map, distance);
  }).toList();
  var radius = 1500.0;
  var nearby = shopsWithDistance
      .where((shop) => shop.distanceInMeters <= radius)
      .toList();

  while (nearby.length < 5 && radius < 50000) {
    radius += 1500;
    nearby = shopsWithDistance
        .where((shop) => shop.distanceInMeters <= radius)
        .toList();
  }

  nearby.sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));

  if (nearby.length > 30) {
    nearby = nearby.sublist(0, 30);
  }

  return nearby;
}
