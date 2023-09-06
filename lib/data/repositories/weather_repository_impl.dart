import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_architecture/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDataSourceImpl remoteDataSourceImpl;
  const WeatherRepositoryImpl(this.remoteDataSourceImpl);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async{
    try{
      var response = await remoteDataSourceImpl.getCurrentWeather(cityName);
      return Right(response.toEntity());
    }on ServerException {
      return Left(ServerFailure('An server error occur'));
    }on SocketException{
      return Left(ServerFailure('Socket error'));
    }
  }

}