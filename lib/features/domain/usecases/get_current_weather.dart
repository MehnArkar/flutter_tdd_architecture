import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/usecases/usecase.dart';

import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase extends Usecase<Either<Failure,WeatherEntity>,String>{
  final WeatherRepository repository;
   GetCurrentWeatherUseCase(this.repository);

  @override
  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
      return repository.getCurrentWeather(cityName);
  }

}