import 'package:weatherapp/feature/bookmark/domain/entitirs/city_entity.dart';
import 'package:weatherapp/feature/bookmark/domain/repository/city_repository.dart';

import '../data_source/local/city_dao.dart';

class CityRepositoryImpl extends CityRepository {
  CityDao cityDao;
  CityRepositoryImpl(this.cityDao);

  /// call save city to DB and set status
  @override
  Future<City> saveCityToDB(String cityName,double lat,double lon) async {
    try {
      // check city exist or not
      City? checkCity = await cityDao.findCityByName(cityName);
      if (checkCity != null) {
        return City("$cityName has Already exist",lat,lon);
      }

      // insert city to database
      City city = City(cityName,lat,lon);
      await cityDao.insertCity(city);
      return city;
    } catch (e) {
      print(e.toString());
      return City(e.toString(),lat,lon);
    }
  }

  /// call get All city from DB and set status
  @override
  Future<List<City>> getAllCityFromDB() async {

      List<City> cities = await cityDao.findAllCity();
      return cities;
    
  }

  /// call  get city by name from DB and set status
  @override
  Future<City?> findCityByName(name) async {
    try {
      City? city = await cityDao.findCityByName(name);
      return city;
    } catch (e) {
      print(e.toString());
      return City(e.toString(),0.0,0.0);
    }
  }

  @override
  Future<String> deleteCityByName(String name) async {
    try {
      await cityDao.deleteCityByName(name);
      return name;
    } catch (e) {
    
      return 'Error';
    }
  }
}
