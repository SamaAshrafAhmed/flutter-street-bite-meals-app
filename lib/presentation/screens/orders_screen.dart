import 'package:flutter/material.dart';
import 'package:street_bite/core/utils/localization.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.ordersEmpty,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
