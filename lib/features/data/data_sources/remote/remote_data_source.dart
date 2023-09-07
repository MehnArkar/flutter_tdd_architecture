import 'dart:convert';
import 'dart:developer';

import 'package:flutter_tdd_architecture/core/constant/constants.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';

import '../../models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource{
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});


  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async{
    final response = await client.get(Uri.parse(Url.currentWeatherByName(cityName)));
    if(response.statusCode==200){
        return WeatherModel.fromJson(jsonDecode(response.body));
    }else{
        throw ServerException();
    }
  }
  
}

