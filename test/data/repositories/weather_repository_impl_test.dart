import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_architecture/data/models/weather_model.dart';
import 'package:flutter_tdd_architecture/data/repositories/weather_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late WeatherRepositoryImpl weatherRepositoryImpl;
  late MockWeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  String testCityName = 'New York';
  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Fog',
      description: 'fog',
      iconCode: '50n',
      temperature: 297.52,
      pressure: 1012,
      humidity: 80);

  setUp(() {
    weatherRemoteDataSourceImpl = MockWeatherRemoteDataSourceImpl();
    weatherRepositoryImpl = WeatherRepositoryImpl(weatherRemoteDataSourceImpl);
  });


  test('Should return success entity', () async{
      //arrange
      when(weatherRemoteDataSourceImpl.getCurrentWeather(testCityName)).thenAnswer((_) async => testWeatherModel);

      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, Right(testWeatherModel.toEntity()));
  });

  test('Should return success entity', () async{
    //arrange
    when(weatherRemoteDataSourceImpl.getCurrentWeather(testCityName)).thenThrow(ServerException());

    final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

    expect(result, Left(ServerFailure('An server error occur')));
  });

  test('Should return success entity', () async{
    //arrange
    when(weatherRemoteDataSourceImpl.getCurrentWeather(testCityName)).thenThrow(SocketException(''));

    final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

    expect(result, Left(ServerFailure('Socket error')));
  });

  
}