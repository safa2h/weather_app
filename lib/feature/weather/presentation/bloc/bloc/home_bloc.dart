import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/core/params/ForecastParams.dart';
import 'package:weatherapp/core/utils/exception.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/current_city_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/forecase_days_entity.dart';
import 'package:weatherapp/feature/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weatherapp/feature/weather/domain/usecases/get_forecast_weather_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase getForecastWeatherUseCase;
  HomeBloc(this.getCurrentWeatherUseCase, this.getForecastWeatherUseCase)
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoadCwEvent) {
        emit(HomeLoadingCw());

        try {
          
          final getCurrentWeather =
              await getCurrentWeatherUseCase.call(event.cityName);  
              
                final getForecast =
              await getForecastWeatherUseCase.call(event.forecastParams);
          emit(HomeSuccessCw(getCurrentWeather,getForecast));
        } catch (e) {
          emit(HomeError(AppException('something going wrong try again')));
        }
       
      }

  
      
    });
  }
}
