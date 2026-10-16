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
              final items = (data['items'] as List<dynamic>?) ?? const [];
              final paymentMethod = data['paymentMethod'] == 'card'
                  ? context.l10n.cardPayment
                  : context.l10n.cashPayment;
              return Card(
                child: ExpansionTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.receipt_long_rounded),
                  ),
                  title: Text('${context.l10n.placeOrder} #${index + 1}'),
                  subtitle: Text(
                    '${context.l10n.itemsCount((data['itemCount'] as int?) ?? 0)} • '
                    '$paymentMethod',
                  ),
                  children: [
                    for (final rawItem in items)
                      if (rawItem is Map<String, dynamic>)
                        ListTile(
                          dense: true,
                          leading: const Icon(Icons.fastfood_outlined),
                          title: Text(
                            (rawItem['meal'] as Map<String, dynamic>?)?['name']
                                    as String? ??
                                context.l10n.appName,
                          ),
                          trailing: Text('×${rawItem['quantity'] ?? 1}'),
                        ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
