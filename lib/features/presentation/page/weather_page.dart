import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_architecture/core/constant/constants.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,),
      body: Padding(
          padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherBloc,WeatherState>(
                builder: (context,state){
                  if(state is WeatherLoading){
                    return const CircularProgressIndicator();
                  }
                  if(state is WeatherLoaded){
                    return Column(
                      key: const Key('weather_key'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(Url.weatherIcon(state.result.iconCode)),
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.result.cityName),
                            const SizedBox(width: 15,),
                            Text(state.result.temperature.toString()+'\'C')
                          ],
                        )
                      ],
                    );
                  }

                  if(state is WeatherLoadFailure){
                    return Text(state.message);
                  }

                  return const SizedBox();

                  // if(state is WeatherLoaded){}
                }
            ),
            const SizedBox(height: 32,),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enty city name',
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              onChanged: (query){
                context.read<WeatherBloc>().add(OnCityChange(query));
              },
            ),


          ],
        ),
      ),
    );
  }
}
