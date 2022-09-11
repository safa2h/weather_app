import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/params/ForecastParams.dart';
import 'package:weatherapp/core/widgets/app_background.dart';
import 'package:weatherapp/core/widgets/error_widget.dart';
import 'package:weatherapp/feature/bookmark/domain/entitirs/city_entity.dart';
import 'package:weatherapp/feature/bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weatherapp/feature/weather/presentation/bloc/bloc/home_bloc.dart';
import 'package:weatherapp/feature/weather/presentation/scressns/home_screen.dart';
import 'package:weatherapp/locator.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key, required this.onTap});
  final GestureTapCallback onTap;

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  void initState() {
    // TODO: implement initState
    locator<BookmarkBloc>()..add(BookmarkStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: mediaquery.size.width,
          height: mediaquery.size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AppBackground.getBackGroundImage()),
          ),
          child: BlocBuilder<BookmarkBloc, BookmarkState>(
            builder: (context, state) {
             
              if (state is BookmarkEmpty) {
                return Center(
                  child: Text('You dont have bookmarked city'),
                );
              }
              if (state is BookmarkLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is BookmarkSuccess) {
                final cities = state.cities;
                return CityList(cities: cities, widget: widget);
              }

              if (state is BookmarkError) {
                return ErrorWidgetCustom(
                    errorMessage: 'error while getting data',
                    tapCallback: () {
                      locator<BookmarkBloc>().add(BookmarkStarted());
                    });
              }
                return ErrorWidgetCustom(
                    errorMessage: 'error while getting data',
                    tapCallback: () {
                      locator<BookmarkBloc>().add(BookmarkStarted());
                    });
             
            },
          ),
        ),
      ),
    );
  }
}

class CityList extends StatelessWidget {
  const CityList({
    Key? key,
    required this.cities,
    required this.widget,
  }) : super(key: key);

  final List<City> cities;
  final BookMarkScreen widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final item = cities[index];
        return Container(
          margin: EdgeInsets.all(26),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.4)),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              BlocProvider.of<BookmarkBloc>(context)
                  .add(BookmarkDeelteCity(cities[index].name));
              BlocProvider.of<BookmarkBloc>(context)
                  .add(BookmarkStarted());
            },
            key: ObjectKey(item),
            background: Container(color: Colors.red),
            child: InkWell(
              onTap: () {
                final params = ForecastParams(
                    cities[index].lat, cities[index].lon);
                locator<HomeBloc>()
                  .add(
                      HomeLoadCwEvent(cities[index].name, params));
                widget.onTap();
              },
              child: ListTile(
                title: Text(
                 cities[index].name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
