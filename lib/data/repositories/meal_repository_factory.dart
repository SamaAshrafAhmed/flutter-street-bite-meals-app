import '../../domain/repositories/meal_repository.dart';
import '../../domain/entities/meal_entity.dart';
import '../datasources/meal_local_datasource.dart';
import '../datasources/meal_remote_datasource.dart';
import 'meal_repository_impl.dart';

/// Factory Pattern for selecting the repository backed by remote or cached data.
///
/// A normal load chooses the cache when it contains meals. A forced refresh
/// chooses the remote repository; that repository still falls back to cache if
/// the refresh request fails.
/// Factory that hides the cache-versus-network repository selection from the
/// domain layer and keeps refresh policy in one place.
class MealRepositoryFactory {
  final MealRemoteDataSource _remote;
  final MealLocalDataSource _local;

  const MealRepositoryFactory({
    required MealRemoteDataSource remote,
    required MealLocalDataSource local,
  }) : _remote = remote,
       _local = local;

  Future<MealRepository> create({bool forceRefresh = false}) async {
    if (!forceRefresh && (await _local.getCachedMeals()).isNotEmpty) {
      return CachedMealRepository(_local);
    }
    return RemoteMealRepository(remote: _remote, local: _local);
  }
}

/// Domain-facing repository that delegates each operation to the factory.
class FactoryMealRepository implements MealRepository {
  final MealRepositoryFactory _factory;

  const FactoryMealRepository(this._factory);

  @override
  Future<List<MealEntity>> getMeals({bool forceRefresh = false}) async {
    final repository = await _factory.create(forceRefresh: forceRefresh);
    return repository.getMeals(forceRefresh: forceRefresh);
  }

  @override
  Future<MealEntity> getMealById(String id) async {
    final repository = await _factory.create(forceRefresh: true);
    return repository.getMealById(id);
  }
}
