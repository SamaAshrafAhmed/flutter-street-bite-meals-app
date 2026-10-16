import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/meal_local_datasource.dart';
import '../datasources/meal_remote_datasource.dart';

abstract class MealRepositoryImpl implements MealRepository {
  const MealRepositoryImpl();

  MealEntity _toEntity(dynamic model) => model.toEntity();
}

class CachedMealRepository extends MealRepositoryImpl {
  final MealLocalDataSource _local;
  const CachedMealRepository(this._local);

  @override
  Future<List<MealEntity>> getMeals({bool forceRefresh = false}) async {
    final models = await _local.getCachedMeals();
    return models.map(_toEntity).toList();
  }

  @override
  Future<MealEntity> getMealById(String id) async {
    final model = await _local.getCachedMealById(id);
    if (model == null) throw StateError('Meal is not available in cache');
    return _toEntity(model);
  }
}

class RemoteMealRepository extends MealRepositoryImpl {
  final MealRemoteDataSource _remote;
  final MealLocalDataSource _local;

  const RemoteMealRepository({
    required MealRemoteDataSource remote,
    required MealLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  @override
  Future<List<MealEntity>> getMeals({bool forceRefresh = false}) async {
    try {
      final models = await _remote.getMeals();
      await _local.cacheMeals(models);
      return models.map(_toEntity).toList();
    } catch (_) {
      final cached = await _local.getCachedMeals();
      if (cached.isNotEmpty) return cached.map(_toEntity).toList();
      rethrow;
    }
  }

  @override
  Future<MealEntity> getMealById(String id) async {
    try {
      return _toEntity(await _remote.getMealById(id));
    } catch (_) {
      final cached = await _local.getCachedMealById(id);
      if (cached == null) rethrow;
      return _toEntity(cached);
    }
  }
}
