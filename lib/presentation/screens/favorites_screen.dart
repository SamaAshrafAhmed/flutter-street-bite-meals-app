import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:street_bite/core/utils/localization.dart';
import '../../data/models/meal_model.dart';
import '../../data/services/firestore_service.dart';
import 'meal_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.favoritesTab)),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirestoreService.instance.watchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final meals =
              snapshot.data?.docs
                  .map((doc) => MealModel.fromJson(doc.data()))
                  .toList() ??
              const <MealModel>[];
          if (meals.isEmpty) {
            return Center(
              child: Text(
                context.l10n.favoritesEmpty,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: meals.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final meal = meals[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: Theme.of(context).colorScheme.surface,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    meal.thumbnailUrl,
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(meal.name),
                subtitle: Text(meal.category),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealDetailsScreen(meal: meal.toEntity()),
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
