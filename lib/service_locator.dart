import 'package:get_it/get_it.dart';
import 'package:mahal_app/bloc/login/login_bloc.dart';
import 'package:mahal_app/bloc/subscription/subscription_bloc.dart';
import 'package:mahal_app/repositories/login_repo.dart';
import 'package:mahal_app/repositories/subscription_repo.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepository());

  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<LoginRepository>()));
  getIt.registerFactory<SubscriptionBloc>(
      () => SubscriptionBloc(getIt<SubscriptionRepository>()));
}
