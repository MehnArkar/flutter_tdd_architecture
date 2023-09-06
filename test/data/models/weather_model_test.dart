


import 'dart:convert';

import 'package:flutter_tdd_architecture/data/models/weather_model.dart';
import 'package:flutter_tdd_architecture/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/json_reader.dart';



void main(){

  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Fog',
      description: 'fog',
      iconCode: '50n',
      temperature: 297.52,
      pressure: 1012,
      humidity: 80);
  
  test(
      'should be a subclass of weather entity',
          () async{
            //assert
            expect(testWeatherModel, isA<WeatherEntity>());
  });
  
  test('should return a valid model form json', () async{
    //arrange
     final Map<String,dynamic> jsonMap = jsonDecode(readJson('helper/dummy_data/dummy_weather_response.json'));
     //act
    final result = WeatherModel.fromJson(jsonMap);
    //assert
    expect(result, equals(testWeatherModel));
  });

  //ToDo: Also implement toJson test
  
}