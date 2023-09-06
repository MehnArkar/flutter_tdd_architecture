import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/domain/entities/weather.dart';
import 'package:flutter_tdd_architecture/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetails = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testCityName = 'New York';

  test('should get current weather details from the repository', () async{
    //arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName)).thenAnswer((_) async=> const Right(testWeatherDetails));

    //act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    //assert
    expect(result, equals(const Right(testWeatherDetails)));

  });
}