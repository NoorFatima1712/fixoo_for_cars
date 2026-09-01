import 'app.dart';
import 'package:flutter/material.dart';

import 'common/services/database_services.dart';
import 'common/services/location_services.dart';
import 'features/shop_list/shop_list_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final position = await LocationServices().getCurrentLocation();
  final shops = await DatabaseService.instance.getAllShops();

  if (position != null) {
    final nearby = getNearbyShops(position, shops);
    print(nearby.length);
  }

  runApp(const MyApp());
}
