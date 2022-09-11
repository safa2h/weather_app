part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class BookmarkStarted extends BookmarkEvent {}

class BookmarkSaveCity extends BookmarkEvent {
  final String cityName;
  final double lat;
  final double lon;

  BookmarkSaveCity(this.cityName, this.lat, this.lon);
}

class BookmarkCityNameEvent extends BookmarkEvent {
  final String cityName;

  BookmarkCityNameEvent(this.cityName);
}

class BookmarkDeelteCity extends BookmarkEvent {
  final String cityName;

  BookmarkDeelteCity(this.cityName);
}
