import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/dependency_injection/injection.dart';
import '../../core/utils/localization.dart';
import '../../data/models/meal_model.dart';
import '../../data/services/firestore_service.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';
import '../cubit/cart_cubit.dart';

class MealDetailsScreen extends StatefulWidget {
  final MealEntity meal;
  const MealDetailsScreen({super.key, required this.meal});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late MealEntity _meal;
  bool _favorite = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _meal = widget.meal;
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      _meal = await getIt<MealRepository>().getMealById(widget.meal.id);
    } catch (_) {
      // The list item remains usable if the detail request is unavailable.
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleFavorite() async {
    await FirestoreService.instance.toggleFavorite(
      MealModel(
        id: _meal.id,
        name: _meal.name,
        category: _meal.category,
        area: _meal.area,
        thumbnailUrl: _meal.thumbnailUrl,
        instructions: _meal.instructions,
      ),
    );
    if (mounted) setState(() => _favorite = !_favorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_meal.name),
        actions: [
          IconButton(
            tooltip: context.l10n.favoriteAction,
            onPressed: _toggleFavorite,
            icon: Icon(_favorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          AspectRatio(
            aspectRatio: 1.45,
            child: Image.network(
              _meal.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Center(
                child: Icon(Icons.broken_image_outlined, size: 56),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _meal.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.category_outlined, size: 18),
                      label: Text(_meal.category),
                    ),
                    Chip(
                      avatar: const Icon(Icons.public_outlined, size: 18),
                      label: Text(_meal.area),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.instructionsLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  _loading || _meal.instructions.isEmpty
                      ? context.l10n.instructionsUnavailable
                      : _meal.instructions,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () {
                    context.read<CartCubit>().addItem(_meal);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.addedToCart(_meal.name)),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: Text(context.l10n.addToCart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
