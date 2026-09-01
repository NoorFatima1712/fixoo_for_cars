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
  final nearby = shopsWithDistance
      .where((shop) => shop.distanceInMeters <= 1500)
      .toList();

  nearby.sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));

  return nearby;
}
