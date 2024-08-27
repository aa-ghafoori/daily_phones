import 'package:daily_phones/src/repair/data/datasources/repair_remote_data_src.dart';
import 'package:daily_phones/src/repair/data/repos/repair_repo_impl.dart';
import 'package:daily_phones/src/repair/domain/repos/repair_repo.dart';
import 'package:daily_phones/src/repair/domain/usecases/usecases.dart';
import 'package:daily_phones/src/repair/presentation/bloc/repair_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final supabase = Supabase.instance.client;

  sl
    ..registerFactory(
      () => RepairBloc(
        getAccessories: sl(),
        getBrands: sl(),
        getProductTypes: sl(),
        getProducts: sl(),
        getRepairs: sl(),
        sendOfferEmail: sl(),
        sendAppointmentEmail: sl(),
      ),
    )
    ..registerLazySingleton(() => GetAccessories(sl()))
    ..registerLazySingleton(() => GetBrands(sl()))
    ..registerLazySingleton(() => GetProductTypes(sl()))
    ..registerLazySingleton(() => GetProducts(sl()))
    ..registerLazySingleton(() => GetRepairs(sl()))
    ..registerLazySingleton(() => SendOfferEmail(sl()))
    ..registerLazySingleton(() => SendAppointmentEmail(sl()))
    ..registerLazySingleton<RepairRepo>(() => RepairRepoImpl(sl()))
    ..registerLazySingleton<RepairRemoteDataSrc>(
      () => RepairRemoteDataSrcImpl(supabase),
    );
}
