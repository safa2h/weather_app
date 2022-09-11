import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/core/utils/exception.dart';
import 'package:weatherapp/feature/bookmark/domain/entitirs/city_entity.dart';
import 'package:weatherapp/feature/bookmark/domain/repository/city_repository.dart';
import 'package:weatherapp/feature/weather/domain/repository/weather_repository.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final CityRepository cityRepository;
  BookmarkBloc(this.cityRepository) : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) async {
      if (event is BookmarkStarted) {
        emit(BookmarkLoading());

        try {
          final citites = await cityRepository.getAllCityFromDB();
          if (citites.isEmpty) {
            emit(BookmarkEmpty());
          } else {
            emit(BookmarkSuccess(citites));
          }
        } catch (e) {
          emit(BookmarkError(AppException('failed to load cities')));
        }
      }

     

      if (event is BookmarkSaveCity) {
        emit(BookmarkLoading());
        try {
          final result = await cityRepository.saveCityToDB(event.cityName,event.lat,event.lon);
          emit(BookmarkSuccesSave(result));
        } catch (e) {
          emit(BookmarkError(AppException('error while saving')));
        }
      }

      if (event is BookmarkDeelteCity) {
        emit(BookmarkLoading());
        try {
          final result = await cityRepository.deleteCityByName(event.cityName);
          emit(BookmarkSuccesDeelte(result));
        } catch (e) {
          emit(BookmarkError(AppException('error while deelting')));
        }
      }
    });
  }
}
