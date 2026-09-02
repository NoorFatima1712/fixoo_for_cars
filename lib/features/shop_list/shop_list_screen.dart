import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/models/shop.dart';
import '../../common/services/database_services.dart';
import '../../common/services/location_services.dart';
import 'shop_list_service.dart';

class ShopListScreen extends StatefulWidget {
  const ShopListScreen({super.key});

  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  bool _isLoading = true;
  bool _locationFailed = false;
  List<Shop> _shops = [];

  @override
  void initState() {
    super.initState();
    _loadShops();
  }

  Future<void> _loadShops() async {
    final position = await LocationServices().getCurrentLocation();
    final shopMaps = await DatabaseService.instance.getAllShops();

    if (position == null) {
      setState(() {
        _isLoading = false;
        _locationFailed = true;
      });
      return;
    }

    setState(() {
      _shops = getNearbyShops(position, shopMaps);
      _isLoading = false;
    });
  }

  Future<void> _callShop(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fixoo')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _locationFailed
          ? const Center(child: Text('Could not get your location'))
          : ListView.builder(
              itemCount: _shops.length,
              itemBuilder: (context, index) {
                final shop = _shops[index];
                return ListTile(
                  title: Text(shop.name),
                  subtitle: Text(
                    '${(shop.distanceInMeters / 1000).toStringAsFixed(1)} km',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () => _callShop(shop.phone),
                  ),
                );
              },
            ),
    );
  }
}
