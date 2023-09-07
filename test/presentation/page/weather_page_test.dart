import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_architecture/data/models/weather_model.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_state.dart';
import 'package:flutter_tdd_architecture/presentation/page/weather_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent,WeatherState> implements WeatherBloc { }


void main() {

  late MockWeatherBloc mockWeatherBloc;

  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Fog',
      description: 'fog',
      iconCode: '50n',
      temperature: 297.52,
      pressure: 1012,
      humidity: 80);

  setUp((){
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global =null;
  });

  Widget makeTestableWidget(Widget body){
    return BlocProvider<WeatherBloc>(
      create: (context)=>mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

testWidgets(
    'test field should trigger state change from empty to loading',
        (widgetTester)  async{
      //arrange
      when(()=>mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);

      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();
      expect(find.text('New York'), findsOneWidget);


});


  testWidgets(
      'test should trigger loading state',
          (widgetTester)  async{
        //arrange
        when(()=>mockWeatherBloc.state).thenReturn(WeatherLoading());

        //act
        await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
        var circularLoadingIndicator = find.byType(TextField);

        expect(circularLoadingIndicator, findsOneWidget);



      });


  testWidgets(
      'test should trigger loaded state',
          (widgetTester)  async{
        //arrange
        when(()=>mockWeatherBloc.state).thenReturn(const WeatherLoaded(testWeatherModel));

        //act
        await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

        //
        await widgetTester.pump(const Duration(milliseconds: 600));

        //assert
        expect(find.byKey(const Key('weather_key')), findsOneWidget);

      });
}