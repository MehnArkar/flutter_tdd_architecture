import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_architecture/injection_container.dart';
import 'package:flutter_tdd_architecture/presentation/bloc/weather_bloc.dart';
import 'package:flutter_tdd_architecture/presentation/page/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLoator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>locator<WeatherBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherPage(),
      ),
    );
  }
}

