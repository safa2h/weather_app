part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeSuccessCw extends HomeState {
  final CurrentCityEntity cityEntity;
  final ForecastDaysEntity forecastDaysEntity;

  const HomeSuccessCw(this.cityEntity, this.forecastDaysEntity);
  @override
  // TODO: implement props
  List<Object> get props => [cityEntity];
}

class HomeLoadingCw extends HomeState {}


class HomeError extends HomeState {
  final AppException appException;

  HomeError(this.appException);
  @override
  // TODO: implement props
  List<Object> get props => [appException];
}
