import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import '../entities/weather.dart';


abstract class WeatherRepository{
  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);
}