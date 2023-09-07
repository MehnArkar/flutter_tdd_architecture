import 'package:flutter_tdd_architecture/features/data/data_sources/remote/remote_data_source.dart';
import 'package:flutter_tdd_architecture/features/domain/repositories/weather_repository.dart';
import 'package:flutter_tdd_architecture/features/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
    [
      WeatherRepository,
      WeatherRemoteDataSourceImpl,
      GetCurrentWeatherUseCase
    ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpCLient)]
)


void main(){

}