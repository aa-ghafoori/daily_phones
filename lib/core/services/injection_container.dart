import 'package:daily_phones/core/database/database_helper.dart';
import 'package:daily_phones/core/res/predefined_data.dart';
import 'package:daily_phones/src/repair/data/datasources/repair_local_data_src.dart';
import 'package:daily_phones/src/repair/data/repos/repair_repo_impl.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:daily_phones/src/repair/domain/usecases/usecases.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingletonAsync<DatabaseHelper>(() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.seedDatabase(
      predefinedBrands: predefinedBrands,
      predefinedProducts: predefinedProducts,
      predefinedAccessories: predefinedAccessories,
      predefinedRepairs: predefinedRepairs,
    );
    return dbHelper;
  });

  await sl.isReady<DatabaseHelper>();

  sl
    ..registerFactory(
      () => RepairBloc(
        getAccessories: sl(),
        getBrands: sl(),
        getProducts: sl(),
        getRepairs: sl(),
      ),
    )
    ..registerLazySingleton(() => GetAccessories(sl()))
    ..registerLazySingleton(() => GetBrands(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => GetRepairs(sl()))
    ..registerLazySingleton<RepairRepo>(() => RepairRepoImpl(sl()))
    ..registerLazySingleton<RepairLocalDataSrc>(
      () => RepairLocalDataSrcImpl(sl()),
    );
}
