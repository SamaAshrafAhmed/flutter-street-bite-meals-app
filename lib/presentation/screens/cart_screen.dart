import 'package:flutter/material.dart';
import 'package:street_bite/core/utils/localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../../data/services/firestore_service.dart';
import '../../domain/services/payment_method.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _CartBody();
  }
}

class _CartBody extends StatefulWidget {
  const _CartBody();

  @override
  State<_CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<_CartBody> {
  PaymentMethod _payment = CashPayment();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.cartTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (ctx, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Theme.of(ctx).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.cartEmpty,
                    style: Theme.of(ctx).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (ctx, idx) {
                    final item = state.items[idx];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.meal.thumbnailUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, _, _) => Container(
                            width: 56,
                            height: 56,
                            color: Theme.of(
                              ctx,
                            ).colorScheme.surfaceContainerHighest,
                            child: const Icon(
                              Icons.broken_image_outlined,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item.meal.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        item.meal.category,
                        style: Theme.of(ctx).textTheme.bodySmall,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '×${item.quantity}',
                            style: Theme.of(ctx).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            tooltip: context.l10n.removeItem,
                            icon: Icon(
                              Icons.remove_circle_outline_rounded,
                              color: Theme.of(ctx).colorScheme.error,
                            ),
                            onPressed: () =>
                                ctx.read<CartCubit>().removeItem(item.meal.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        initialValue: _payment.name,
                        decoration: InputDecoration(
                          labelText: context.l10n.paymentMethod,
                          prefixIcon: const Icon(Icons.payments_outlined),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'cash',
                            child: Text(context.l10n.cashPayment),
                          ),
                          DropdownMenuItem(
                            value: 'card',
                            child: Text(context.l10n.cardPayment),
                          ),
                        ],
                        onChanged: (value) => setState(() {
                          _payment = value == 'card'
                              ? CardPayment()
                              : CashPayment();
                        }),
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () async {
                          final itemCount = state.itemCount;
                          try {
                            await _payment.pay(amount: itemCount.toDouble());
                            await FirestoreService.instance.saveOrder(
                              items: state.items
                                  .map(
                                    (item) => {
                                      'quantity': item.quantity,
                                      'meal': {
                                        'id': item.meal.id,
                                        'name': item.meal.name,
                                        'category': item.meal.category,
                                        'area': item.meal.area,
                                        'country': item.meal.country,
                                        'thumbnailUrl': item.meal.thumbnailUrl,
                                        'instructions': item.meal.instructions,
                                      },
                                    },
                                  )
                                  .toList(),
                              itemCount: itemCount,
                              paymentMethod: _payment.name,
                            );
                            if (!context.mounted) return;
                            context.read<CartCubit>().clearAll();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(context.l10n.orderPlaced)),
                            );
                          } on FirebaseException {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.firebaseDataError),
                              ),
                            );
                          } catch (_) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.errorUnknown),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.receipt_long_rounded),
                        label: Text(context.l10n.placeOrder),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
