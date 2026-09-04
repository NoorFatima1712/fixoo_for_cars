import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/shop.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/services/database_services.dart';
import '../../../core/services/location_services.dart';
import '../data/shop_list_service.dart';

class ShopListScreen extends StatefulWidget {
  const ShopListScreen({super.key, required this.onToggleLanguage});

  final VoidCallback onToggleLanguage;

  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  bool _isLoading = true;
  bool _locationFailed = false;
  List<Shop> _shops = [];
  int _minResults = 5;

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
      _shops = getNearbyShops(position, shopMaps, minResults: _minResults);
      _isLoading = false;
    });
  }

  void _showMoreShops() {
    setState(() {
      _minResults += 10;
    });
    _loadShops();
  }

  Future<void> _dialNumber(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }

  Widget _buildEmergencyBar(AppLocalizations text) {
    return Container(
      color: Colors.red.shade50,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.emergency),
              label: Text(text.emergencyRescue),
              onPressed: () => _dialNumber('1122'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.local_police),
              label: Text(text.emergencyMotorway),
              onPressed: () => _dialNumber('130'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(text.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.onToggleLanguage,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildEmergencyBar(text),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _locationFailed
                ? Center(child: Text(text.locationFailed))
                : ListView.builder(
                    itemCount: _shops.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _shops.length) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: OutlinedButton(
                            onPressed: _showMoreShops,
                            child: Text(text.showMoreShops),
                          ),
                        );
                      }
                      final shop = _shops[index];
                      return ListTile(
                        title: Text(shop.name),
                        subtitle: Text(
                          text.distanceKm(
                            (shop.distanceInMeters / 1000).toStringAsFixed(1),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () => _dialNumber(shop.phone),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
