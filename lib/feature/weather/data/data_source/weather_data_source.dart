import 'package:weatherapp/core/params/ForecastParams.dart';
import 'package:weatherapp/core/utils/http_service.dart';
import 'package:weatherapp/core/utils/http_validator.dart';
import 'package:weatherapp/feature/weather/data/models/ForcastDaysModel.dart';
import 'package:weatherapp/feature/weather/data/models/curernt_city_model.dart';
import 'package:weatherapp/feature/weather/data/models/suggest_city_model.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/forecase_days_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/suggest_city_entity.dart';

import '../../../../core/utils/consts.dart';
import '../../domain/entitirs/current_city_entity.dart';

abstract class WeatherDataSuorce {
  Future<CurrentCityEntity> getCurrentWaather(String cityName);
  Future<ForecastDaysEntity> sendRequest7DaysForcast(ForecastParams params);
  Future<SuggestCityEntity> sendRequestCitySuggestion(String prefix);
}

class RemoteWeatherDataSource with HttpValidator implements WeatherDataSuorce {
  final HttpService httpService;

  RemoteWeatherDataSource(this.httpService);
  @override
  Future<CurrentCityEntity> getCurrentWaather(String cityName) async {
    var response = await httpService.getRequest('data/2.5/weather',
        {'q': cityName, 'units': 'metric', 'appid': Contants.apiKey});

    responseValidator(response);
    CurrentCityEntity cityEntity = CurrentCityModel.fromJson((response.data)as Map<String ,dynamic>);
    return cityEntity;
  }

  /// 7 days forecast api
  Future<ForecastDaysEntity> sendRequest7DaysForcast(
      ForecastParams params) async {
    final response =
        await httpService.getRequest("${Contants.baseUrl}/data/2.5/onecall", {
      'lat': params.lat,
      'lon': params.lon,
      'exclude': 'minutely,hourly',
      'appid': Contants.apiKey,
      'units': 'metric'
    });
    responseValidator(response);
    ForecastDaysEntity forecastDaysEntity =
        ForecastDaysModel.fromJson(response.data);

    return forecastDaysEntity;
  }

  Future<SuggestCityEntity> sendRequestCitySuggestion(String prefix) async {
    var response = await httpService.getRequest(
        "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
        {'limit': 7, 'offset': 0, 'namePrefix': prefix});

    responseValidator(response);


    return SuggestCityModel.fromJson(response.data);
  }
}
