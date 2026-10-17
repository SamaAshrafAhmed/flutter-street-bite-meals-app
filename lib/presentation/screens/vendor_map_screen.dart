import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/localization.dart';

class VendorMapScreen extends StatelessWidget {
  const VendorMapScreen({super.key});

  static const _vendors = [
    (
      nameKey: 'cairoVendor',
      cuisineKey: 'egyptianCuisine',
      rating: '4.6',
      lat: 30.0444,
      lng: 31.2357,
    ),
    (
      nameKey: 'alexandriaVendor',
      cuisineKey: 'alexandriaCuisine',
      rating: '4.8',
      lat: 31.2001,
      lng: 29.9187,
    ),
    (
      nameKey: 'gizaVendor',
      cuisineKey: 'gizaCuisine',
      rating: '4.8',
      lat: 29.9792,
      lng: 31.1342,
    ),
    (
      nameKey: 'luxorVendor',
      cuisineKey: 'luxorCuisine',
      rating: '4.7',
      lat: 25.6872,
      lng: 32.6396,
    ),
    (
      nameKey: 'aswanVendor',
      cuisineKey: 'aswanCuisine',
      rating: '4.9',
      lat: 24.0889,
      lng: 32.8998,
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
                    '${_cuisineName(context, vendor.cuisineKey)} • '
                    '${context.l10n.ratingLabel(vendor.rating)}',
              ),
            ),
        },
      ),
    );
  }

  String _vendorName(BuildContext context, String key) => switch (key) {
    'cairoVendor' => context.l10n.cairoVendor,
    'alexandriaVendor' => context.l10n.alexandriaVendor,
    'gizaVendor' => context.l10n.gizaVendor,
    'luxorVendor' => context.l10n.luxorVendor,
    _ => context.l10n.aswanVendor,
  };

  String _cuisineName(BuildContext context, String key) => switch (key) {
    'egyptianCuisine' => context.l10n.egyptianCuisine,
    'alexandriaCuisine' => context.l10n.alexandriaCuisine,
    'gizaCuisine' => context.l10n.gizaCuisine,
    'luxorCuisine' => context.l10n.luxorCuisine,
    _ => context.l10n.aswanCuisine,
  };
}
