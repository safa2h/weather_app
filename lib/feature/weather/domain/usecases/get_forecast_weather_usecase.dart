
import 'package:weatherapp/core/use_case/use_case.dart';

import '../../../../core/params/ForecastParams.dart';
import '../entitirs/forecase_days_entity.dart';
import '../repository/weather_repository.dart';

class GetForecastWeatherUseCase implements UseCase<ForecastDaysEntity, ForecastParams>{
  final WeatherRepository _weatherRepository;
  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<ForecastDaysEntity> call(ForecastParams params) {
    return _weatherRepository.sendRequest7DaysForcast(params);
  }

}