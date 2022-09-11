part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();

  @override
  List<Object> get props => [];
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}
class BookmarkEmpty extends BookmarkState {}

class BookmarkError extends BookmarkState {
  final AppException appException;

  BookmarkError(this.appException);
}

class BookmarkSuccess extends BookmarkState {
  final List<City> cities;

  BookmarkSuccess(this.cities);
}
class BookmarkSuccesSave extends BookmarkState {
  final City citiy;

  BookmarkSuccesSave(this.citiy);
}
class BookmarkSuccesDeelte extends BookmarkState {
  final String citiyName;

  BookmarkSuccesDeelte(this.citiyName);
}
class BookmarkCityName extends BookmarkState {
  final bool isAlreadyHas;

  BookmarkCityName(this.isAlreadyHas);
}
