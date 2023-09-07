import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_architecture/core/error/failure.dart';
import 'package:flutter_tdd_architecture/data/models/weather_model.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeatherUseCase weatherUseCase;

  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Fog',
      description: 'fog',
      iconCode: '50n',
      temperature: 297.52,
      pressure: 1012,
      humidity: 80);

  const cityName = 'New York';


  setUp(() {
    weatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(weatherUseCase);
  });

  test('init state should be empty', () {
      expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc,WeatherState>(
  'should emit weather loading and weather loaded',
    build:(){
    when(weatherUseCase.execute(cityName)).thenAnswer((_) async => const Right(testWeatherModel));
    return weatherBloc;
    },
    act:(bloc)=> bloc.add(const OnCityChange(cityName)),
    wait: const Duration(milliseconds: 500),
    expect: ()=>[
      WeatherLoading(),
      const WeatherLoaded(testWeatherModel)
    ]
  );


  blocTest<WeatherBloc,WeatherState>(
      'should emit weather loading and weather loaded',
      build:(){
        when(weatherUseCase.execute(cityName)).thenAnswer((_) async => const Left(ServerFailure('An error occur')));
        return weatherBloc;
      },
      act:(bloc)=> bloc.add(const OnCityChange(cityName)),
      wait: const Duration(milliseconds: 500),
      expect: ()=>[
        WeatherLoading(),
        const WeatherLoadFailure('An error occur')
      ]
  );
}