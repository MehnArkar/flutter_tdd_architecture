import 'package:flutter_tdd_architecture/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_architecture/data/repositories/weather_repository_impl.dart';
import 'package:flutter_tdd_architecture/domain/repositories/weather_repository.dart';
import 'package:flutter_tdd_architecture/domain/usecases/get_current_weather.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

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