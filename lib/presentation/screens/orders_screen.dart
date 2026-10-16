import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:street_bite/core/utils/localization.dart';
import '../../data/services/firestore_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.ordersHistory)),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirestoreService.instance.watchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data?.docs ?? const [];
          if (orders.isEmpty) {
            return Center(child: Text(context.l10n.noOrders));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final data = orders[index].data();
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.receipt_long_rounded),
                  ),
                  title: Text('${context.l10n.placeOrder} #${index + 1}'),
                  subtitle: Text(
                    context.l10n.itemsCount((data['itemCount'] as int?) ?? 0),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
