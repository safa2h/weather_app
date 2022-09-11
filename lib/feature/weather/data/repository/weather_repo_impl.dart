import 'package:weatherapp/core/params/ForecastParams.dart';
import 'package:weatherapp/feature/weather/data/data_source/weather_data_source.dart';
import 'package:weatherapp/feature/weather/data/models/suggest_city_model.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/current_city_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/forecase_days_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/suggest_city_entity.dart';
import 'package:weatherapp/feature/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImple implements WeatherRepository {
  final WeatherDataSuorce weatherDataSuorce;

  WeatherRepositoryImple(this.weatherDataSuorce);

  @override
  Future<CurrentCityEntity> fecthCurrentWeather(String cityName) {
    return weatherDataSuorce.getCurrentWaather(cityName);
  }

  @override
  Future<ForecastDaysEntity> sendRequest7DaysForcast(ForecastParams params) {
    return weatherDataSuorce.sendRequest7DaysForcast(params);
  }

  @override
  Future<List<Data>> sendRequestCitySuggestion(String prefix) async {
    // TODO: implement sendRequestCitySuggestion

    SuggestCityEntity suggestCityEntity =
        await weatherDataSuorce.sendRequestCitySuggestion(prefix);

    return suggestCityEntity.data!;
  }
}
