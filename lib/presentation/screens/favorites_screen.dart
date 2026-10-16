import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/utils/localization.dart';
import 'package:street_bite/presentation/cubit/favorites_cubit.dart';
import 'meal_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit()..load(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(context.l10n.favoritesTab)),
          body: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.meals.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.favoritesEmpty,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.meals.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, index) {
                  final meal = state.meals[index];
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
                        builder: (_) =>
                            MealDetailsScreen(meal: meal.toEntity()),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
