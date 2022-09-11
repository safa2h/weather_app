
import 'package:weatherapp/feature/bookmark/domain/entitirs/city_entity.dart';

abstract class CityRepository{

  Future<City> saveCityToDB(String cityName,double lat,double lon);

  Future<List<City>> getAllCityFromDB();

  Future<City?> findCityByName(String name);

  Future<String> deleteCityByName(String name);


}