import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_architecture/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase{
  final WeatherRepository repository;
  const GetCurrentWeatherUseCase(this.repository);

  Future<Either<Failure,WeatherEntity>> execute(String cityName) async{
    return repository.getCurrentWeather(cityName);
  }
}