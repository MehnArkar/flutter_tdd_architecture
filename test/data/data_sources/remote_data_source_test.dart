import 'package:flutter_tdd_architecture/core/constant/constants.dart';
import 'package:flutter_tdd_architecture/core/error/exception.dart';
import 'package:flutter_tdd_architecture/data/data_sources/remote_data_source.dart';
import 'package:flutter_tdd_architecture/data/models/weather_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import '../../helper/json_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late WeatherRemoteDataSourceImpl remoteDataSourceImpl;
  late MockHttpCLient cLient;
  String testCity = 'New York';

  setUp((){
    cLient = MockHttpCLient();
    remoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: cLient);
  });

  group(
      'should retrun weather model when the response code is 200',
          () {
        test('should return weather model when success', () async{
          //arrange
          when(cLient.get(Uri.parse(Url.currentWeatherByName(testCity)))).thenAnswer((_) async{
              return http.Response(readJson('helper/dummy_data/dummy_weather_response.json'),200);
          });

          //act
          final result = await remoteDataSourceImpl.getCurrentWeather(testCity);

          //assert
          expect(result, isA<WeatherModel>());

        });

        test('should return ServerException', () async{
          //arrange
          when(cLient.get(Uri.parse(Url.currentWeatherByName(testCity)))).thenAnswer((_) async{
            return http.Response('Not found',404);
          });

          //act
          final result = await remoteDataSourceImpl.getCurrentWeather(testCity);

          //assert
          expect(result, throwsA(isA<ServerException>()));

        });
          });
}