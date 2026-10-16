import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/localization.dart';

class VendorMapScreen extends StatelessWidget {
  const VendorMapScreen({super.key});

  static const _vendors = [
    (
      nameKey: 'cairoVendor',
      cuisineKey: 'egyptianCuisine',
      lat: 30.0444,
      lng: 31.2357,
    ),
    (
      nameKey: 'alexandriaVendor',
      cuisineKey: 'mediterraneanCuisine',
      lat: 31.2001,
      lng: 29.9187,
    ),
    (
      nameKey: 'dubaiVendor',
      cuisineKey: 'arabianCuisine',
      lat: 25.2048,
      lng: 55.2708,
    ),
    (
      nameKey: 'ammanVendor',
      cuisineKey: 'levantineCuisine',
      lat: 31.9539,
      lng: 35.9106,
    ),
    (
      nameKey: 'riyadhVendor',
      cuisineKey: 'saudiCuisine',
      lat: 24.7136,
      lng: 46.6753,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.nearbyVendors)),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(27.5, 35),
          zoom: 4.5,
        ),
        markers: {
          for (final vendor in _vendors)
            Marker(
              markerId: MarkerId(vendor.nameKey),
              position: LatLng(vendor.lat, vendor.lng),
              infoWindow: InfoWindow(
                title: _vendorName(context, vendor.nameKey),
                snippet:
                    '${_cuisineName(context, vendor.cuisineKey)} • ${context.l10n.ratingFive}',
              ),
            ),
        },
      ),
    );
  }

  String _vendorName(BuildContext context, String key) => switch (key) {
    'cairoVendor' => context.l10n.cairoVendor,
    'alexandriaVendor' => context.l10n.alexandriaVendor,
    'dubaiVendor' => context.l10n.dubaiVendor,
    'ammanVendor' => context.l10n.ammanVendor,
    _ => context.l10n.riyadhVendor,
  };

  String _cuisineName(BuildContext context, String key) => switch (key) {
    'egyptianCuisine' => context.l10n.egyptianCuisine,
    'mediterraneanCuisine' => context.l10n.mediterraneanCuisine,
    'arabianCuisine' => context.l10n.arabianCuisine,
    'levantineCuisine' => context.l10n.levantineCuisine,
    _ => context.l10n.saudiCuisine,
  };
}
