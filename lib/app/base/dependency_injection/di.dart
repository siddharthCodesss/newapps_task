import 'package:get_it/get_it.dart';
// import 'package:vritti_task/base/database_helper/database_helper.dart';
// import 'package:vritti_task/screens/home/cubit/cubit.dart';
// import 'package:vritti_task/screens/home/data/repository.dart';
import '../network_sensitive/cubit/internet_cubit.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<InternetCubit>(() => InternetCubit());
  // sl.registerFactory<EmployeeManagementCubit>(() => EmployeeManagementCubit(sl(), sl()));
  // sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  // sl.registerFactory<EmployeeDetailsRepository>(() => EmployeeDetailsRepositoryImpl());
}
