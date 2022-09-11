part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadCwEvent extends HomeEvent {
  final String cityName;
  final ForecastParams forecastParams;


  const HomeLoadCwEvent(this.cityName, this.forecastParams);

  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}


