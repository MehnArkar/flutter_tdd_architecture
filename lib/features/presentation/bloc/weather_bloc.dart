import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_architecture/features/presentation/bloc/weather_event.dart';
import 'package:flutter_tdd_architecture/features/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecases/get_current_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase):super(WeatherEmpty()){
    on<OnCityChange>(
      onCityChange,
      transformer:debounce(const Duration(milliseconds: 500))
    );
  }

  onCityChange(OnCityChange onCityChange,Emitter<WeatherState> emit) async{
    emit(WeatherLoading());
    final result = await _getCurrentWeatherUseCase.execute(onCityChange.cityName);
    result.fold(
            (failure) => emit(WeatherLoadFailure(failure.message)),
            (data) => emit(WeatherLoaded(data))
    );

  }

}

EventTransformer<T> debounce<T>(Duration duration){
  return (events,mapper)=> events.debounceTime(duration).flatMap(mapper);
}

