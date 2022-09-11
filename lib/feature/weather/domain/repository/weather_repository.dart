import 'package:weatherapp/core/params/ForecastParams.dart';
import 'package:weatherapp/feature/weather/data/models/suggest_city_model.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/current_city_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/forecase_days_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/suggest_city_entity.dart';

abstract class WeatherRepository {
  Future<CurrentCityEntity> fecthCurrentWeather(String cityName);
    Future<ForecastDaysEntity> sendRequest7DaysForcast(ForecastParams params);
     Future<List<Data>> sendRequestCitySuggestion(String prefix);

}
