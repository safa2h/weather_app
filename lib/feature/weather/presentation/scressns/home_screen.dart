import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weatherapp/core/params/ForecastParams.dart';
import 'package:weatherapp/core/utils/date_converter.dart';
import 'package:weatherapp/core/widgets/app_background.dart';
import 'package:weatherapp/core/widgets/error_widget.dart';
import 'package:weatherapp/feature/bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weatherapp/feature/weather/data/models/ForcastDaysModel.dart';
import 'package:weatherapp/feature/weather/data/models/suggest_city_model.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/current_city_entity.dart';
import 'package:weatherapp/feature/weather/domain/entitirs/forecase_days_entity.dart';
import 'package:weatherapp/feature/weather/domain/usecases/get_suggestion_city_usecase.dart';
import 'package:weatherapp/feature/weather/presentation/bloc/bloc/home_bloc.dart';
import 'package:weatherapp/feature/weather/presentation/widgets/day_weather_view.dart';
import 'package:weatherapp/locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  TextEditingController textEditingController = TextEditingController();

  GetSuggestionCityUseCase getSuggestionCityUseCase =
      GetSuggestionCityUseCase(locator());

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => locator<HomeBloc>()
        ..add(HomeLoadCwEvent('tehran', ForecastParams(35.5501, 51.5150))),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: mediaquery.size.width,
            height: mediaquery.size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AppBackground.getBackGroundImage(),),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: textEditingController,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: 'Enter City Name',
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),),),),
                  itemBuilder: (context, Data itemData) {
                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(itemData.name.toString()),
                      subtitle:
                          Text('${itemData.region} , ${itemData.country}'),
                    );
                  },
                  onSuggestionSelected: (Data data) {
                    textEditingController.text = data.name.toString();

                    locator<HomeBloc>().add(HomeLoadCwEvent(data.name!,
                        ForecastParams(data.latitude!, data.longitude!),),);
                    textEditingController.text = 'Enter City Name';
                  },
                  suggestionsCallback: (prefix) {
                    return getSuggestionCityUseCase(prefix);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoadingCw) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is HomeSuccessCw) {
                        final CurrentCityEntity cityEntity = state.cityEntity;
                        final ForecastDaysEntity forecastDaysEntity =
                            state.forecastDaysEntity;
                        final sunrise = DateConverter.changeDtToDateTimeHour(
                            cityEntity.sys!.sunrise, cityEntity.timezone,);
                        final sunset = DateConverter.changeDtToDateTimeHour(
                            cityEntity.sys!.sunset, cityEntity.timezone,);

                        return ListView(children: [
                          SizedBox(
                            height: 400,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  allowImplicitScrolling: true,
                                  itemCount: 2,
                                  controller: pageController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return CurrentWeatherShow(
                                        cityEntity: cityEntity,
                                      );
                                    } else {
                                      return const HumityWidget();
                                    }
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Center(
                                    child: SmoothPageIndicator(
                                      controller: pageController,
                                      count: 2,
                                      onDotClicked: (index) {
                                        pageController.animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 500,),
                                            curve: Curves.linear,);
                                      },
                                      effect: const ExpandingDotsEffect(
                                        dotWidth: 10,
                                        dotHeight: 10,
                                        spacing: 5,
                                        activeDotColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              color: Colors.white24,
                              height: 2,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Center(
                                  child: BlocBuilder<HomeBloc, HomeState>(
                                      builder: (BuildContext context, state) {
                                    /// show Loading State for Fw

                                    /// show Completed State for Fw

                                    /// casting

                                    final List<Daily> mainDaily =
                                        forecastDaysEntity.daily!;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 8,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        return DaysWeatherView(
                                          daily: mainDaily[index],
                                        );
                                      },
                                    );
                                  }

                                      /// show Error State for Fw

                                      /// show Default State for Fw

                                     , ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              color: Colors.white24,
                              height: 2,
                              width: double.infinity,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "wind speed",
                                    style: TextStyle(
                                      fontSize: mediaquery.size.height * 0.017,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "${cityEntity.wind!.speed!} m/s",
                                      style: TextStyle(
                                        fontSize:
                                            mediaquery.size.height * 0.016,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "sunrise",
                                      style: TextStyle(
                                        fontSize:
                                            mediaquery.size.height * 0.017,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        sunrise,
                                        style: TextStyle(
                                          fontSize:
                                              mediaquery.size.height * 0.016,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "sunset",
                                      style: TextStyle(
                                        fontSize:
                                            mediaquery.size.height * 0.017,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        sunset,
                                        style: TextStyle(
                                          fontSize:
                                              mediaquery.size.height * 0.016,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  color: Colors.white24,
                                  height: 30,
                                  width: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "humidity",
                                      style: TextStyle(
                                        fontSize:
                                            mediaquery.size.height * 0.017,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "${cityEntity.main!.humidity!}%",
                                        style: TextStyle(
                                          fontSize:
                                              mediaquery.size.height * 0.016,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ]);
                      } else {
                        return ErrorWidgetCustom(
                            errorMessage: 'error while getting data',
                            tapCallback: () {
                              ForecastParams forecastParams =
                                  ForecastParams(35.5501, 51.5150);
                              BlocProvider.of<HomeBloc>(context).add(
                                  HomeLoadCwEvent('tehran',
                                      ForecastParams(35.5501, 51.5150)));
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HumityWidget extends StatelessWidget {
  const HumityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text('himity')),
    );
  }
}

class CurrentWeatherShow extends StatefulWidget {
  CurrentWeatherShow({
    Key? key,
    required this.cityEntity,
  }) : super(key: key);

  final CurrentCityEntity cityEntity;

  @override
  State<CurrentWeatherShow> createState() => _CurrentWeatherShowState();
}

class _CurrentWeatherShowState extends State<CurrentWeatherShow> {
  final bookmarkBloc = locator<BookmarkBloc>();
   late StreamSubscription  streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
   
    // ignore: avoid_dynamic_calls
    streamSubscription =  (bookmarkBloc.stream.listen((state) {
      if (state is BookmarkSuccesSave) {
        final cityname = state.citiy.name;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$cityname added to bookamrk')),);
      }
    }))as StreamSubscription ;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.cityEntity.name}',
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              IconButton(
                  onPressed: () {
                    bookmarkBloc.add(BookmarkSaveCity(
                        widget.cityEntity.name!,
                        widget.cityEntity.coord!.lat!,
                        widget.cityEntity.coord!.lat!));
                  },
                  icon: Icon(
                    Icons.bookmark_add,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            '${widget.cityEntity.weather![0].description}',
            style: const TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AppBackground.setIconForMain(
              widget.cityEntity.weather![0].description),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.cityEntity.main!.temp!.round()}',
                  style: const TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
              const Positioned(
                  right: 0,
                  child: Icon(
                    Icons.circle_outlined,
                    size: 10,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  'Max',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.cityEntity.main!.tempMax!.round().toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              color: Colors.grey,
              width: 2,
              height: 36,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              children: [
                const Text(
                  'Min',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.cityEntity.main!.tempMin!.round().toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
