import 'package:floor/floor.dart';
import 'package:weatherapp/feature/bookmark/domain/entitirs/city_entity.dart';

@dao
abstract class CityDao {
  @Query('SELECT * FROM City')
  Future<List<City>> findAllCity();

  @Query('SELECT * FROM City WHERE id = :id')
  Future<City?> findCityById(int id);

  @Query('SELECT * FROM City WHERE name = :name')
  Future<City?> findCityByName(String name);

  @insert
  Future<void> insertCity(City city);

  @Query('DELETE FROM City WHERE name = :name')
  Future<void> deleteCityByName(String name);
}
