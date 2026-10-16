import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/meal_model.dart';
import '../../data/services/firestore_service.dart';

class FavoritesState {
  final List<MealModel> meals;
  final bool loading;
  const FavoritesState({this.meals = const [], this.loading = false});
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  Future<void> load() async {
    emit(FavoritesState(meals: state.meals, loading: true));
    try {
      emit(
        FavoritesState(meals: await FirestoreService.instance.loadFavorites()),
      );
    } catch (_) {
      emit(FavoritesState(meals: state.meals));
    }
  }

  Future<void> toggle(MealModel meal) async {
    await FirestoreService.instance.toggleFavorite(meal);
    await load();
  }
}
