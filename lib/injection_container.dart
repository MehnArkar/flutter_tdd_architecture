import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/data/data_sources/remote/remote_data_source.dart';
import 'features/data/repositories/weather_repository_impl.dart';
import 'features/domain/repositories/weather_repository.dart';
import 'features/domain/usecases/get_current_weather.dart';
import 'features/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLoator(){

  //http client
  locator.registerLazySingleton<http.Client>(() => http.Client());

  //DataSource (should register source implementation)
  locator.registerLazySingleton<WeatherRemoteDataSourceImpl>(()=>WeatherRemoteDataSourceImpl(client: locator()));

  //Repository (should register repository implementation)
  locator.registerLazySingleton<WeatherRepository>(()=>WeatherRepositoryImpl(locator()));

  //Usecase
  locator.registerLazySingleton<GetCurrentWeatherUseCase>(()=>GetCurrentWeatherUseCase(locator()));

  //Bloc (should not register siglen)
  locator.registerFactory<WeatherBloc>(() => WeatherBloc(locator()));
  
}