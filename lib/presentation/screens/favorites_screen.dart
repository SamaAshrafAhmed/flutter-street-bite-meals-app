import 'package:flutter/material.dart';
import 'package:street_bite/core/utils/localization.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.favoritesEmpty,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
