// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:weatherapp/feature/bookmark/data/data_source/local/city_dao.dart';
import 'package:weatherapp/feature/bookmark/domain/entitirs/city_entity.dart';


part 'app_data_base.g.dart'; // the generated code will be there

@Database(version: 1, entities: [City])
abstract class AppDatabase extends FloorDatabase {
  CityDao get personDao;
}
