import 'package:flutter/cupertino.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/current_city_entity.dart';

class CurrentCityModel extends CurrentCityEntity {
  CurrentCityModel({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Rain? rain,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) : super(
          coord: coord,
          weather: weather,
          base: base,
          main: main,
          visibility: visibility,
          wind: wind,
          rain: rain,
          clouds: clouds,
          dt: dt,
          sys: sys,
          timezone: timezone,
          id: id,
          name: name,
          cod: cod,
        );

  factory CurrentCityModel.fromJson(Map<String, dynamic> json) {
    var weather =<Weather> [];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v as Map<String,dynamic>));
      });
    }
    return CurrentCityModel(
        coord:json['coord'] != null ? new Coord.fromJson(json['coord']as Map<String,dynamic>) : null,
            weather: weather,
            base:json['base'] as String?,
            main: json['main'] != null ? new Main.fromJson(json['main']as Map<String ,dynamic>) : null,
            visibility: json['visibility'] as int?,
            wind:json['wind'] != null ? new Wind.fromJson(json['wind']as Map<String ,dynamic>) : null,
            rain: json['rain'] != null ? new Rain.fromJson(json['rain']as Map<String ,dynamic>) : null,
            clouds:  json['clouds'] != null ? new Clouds.fromJson(json['clouds']as Map<String ,dynamic>) : null,
            dt: json['dt'] as int?,
            sys: json['sys'] != null ? new Sys.fromJson(json['sys']as Map<String ,dynamic>) : null,
            timezone: json['timezone']as int,
            id: json['id'] as int?,
            name: json['name']as String?,
            cod:   json['cod'] as int?,
             );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord!.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    data['base'] = this.base;
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    data['visibility'] = this.visibility;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    if (this.rain != null) {
      data['rain'] = this.rain!.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds!.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys!.toJson();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon']as double?;
    lat = json['lat']as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    main = json['main'] as String?;
    description = json['description']as String?;
    icon = json['icon']as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp']as double?;
    feelsLike = json['feels_like']as double?;
    tempMin = json['temp_min'] as double?;
    tempMax = json['temp_max']as double?;
    pressure = json['pressure']as int?;
    humidity = json['humidity']as int?;
    seaLevel = json['sea_level']as int?;
    grndLevel = json['grnd_level']as int ?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    return data;
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']as double?;
    deg = json['deg']as int?;
    gust = json['gust']as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    data['gust'] = this.gust;
    return data;
  }
}

class Rain {
  double? d1h;

  Rain({this.d1h});

  Rain.fromJson(Map<String, dynamic> json) {
    d1h = json['1h']as double;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1h'] = this.d1h;
    return data;
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all']as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type']as int?;
    id = json['id']as int?;
    country = json['country']as String?;
    sunrise = json['sunrise']as int?;
    sunset = json['sunset']as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}
