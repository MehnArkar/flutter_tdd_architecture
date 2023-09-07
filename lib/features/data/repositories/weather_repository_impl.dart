import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/remote/remote_data_source.dart';


class WeatherRepositoryImpl implements WeatherRepository{
  final WeatherRemoteDataSourceImpl remoteDataSourceImpl;
  const WeatherRepositoryImpl(this.remoteDataSourceImpl);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async{
    try{
      var response = await remoteDataSourceImpl.getCurrentWeather(cityName);
      return Right(response.toEntity());
    }on ServerException {
      return const Left(ServerFailure('An server error occur'));
    }on SocketException{
      return const Left(ServerFailure('Socket error'));
    }
  }

}