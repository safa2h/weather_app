import 'package:weatherapp/core/use_case/use_case.dart';
import 'package:weatherapp/feature/weather/domain/repository/weather_repository.dart';

import '../entitirs/current_city_entity.dart';

class GetCurrentWeatherUseCase
    implements UseCase<CurrentCityEntity, String> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  @override
  Future<CurrentCityEntity> call(String params) {
    return weatherRepository.fecthCurrentWeather(params);
  }
}
