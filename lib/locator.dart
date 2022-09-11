import 'package:get_it/get_it.dart';
import 'package:weatherapp/core/utils/http_service.dart';
import 'package:weatherapp/feature/bookmark/data/data_source/local/app_data_base.dart';
import 'package:weatherapp/feature/bookmark/data/repository/city_repositoryimpl.dart';
import 'package:weatherapp/feature/bookmark/domain/repository/city_repository.dart';
import 'package:weatherapp/feature/bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weatherapp/feature/weather/data/data_source/weather_data_source.dart';
import 'package:weatherapp/feature/weather/data/repository/weather_repo_impl.dart';
import 'package:weatherapp/feature/weather/domain/repository/weather_repository.dart';
import 'package:weatherapp/feature/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weatherapp/feature/weather/domain/usecases/get_forecast_weather_usecase.dart';
import 'package:weatherapp/feature/weather/presentation/bloc/bloc/home_bloc.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton<HttpService>(HttpServiceImple());
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  locator
      .registerSingleton<WeatherDataSuorce>(RemoteWeatherDataSource(locator()));
      locator
      .registerSingleton<CityRepository>(CityRepositoryImpl(database.personDao));
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImple(locator()));
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(
      GetForecastWeatherUseCase(locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
   locator.registerSingleton<BookmarkBloc>(BookmarkBloc(locator()));
}
