import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/widgets/root.dart';
import 'package:weatherapp/feature/bookmark/presentation/bloc/bloc/bookmark_bloc.dart';
import 'package:weatherapp/feature/weather/presentation/bloc/bloc/home_bloc.dart';
import 'package:weatherapp/locator.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  //init locator
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
    
      providers: [
      BlocProvider<HomeBloc>(create:(context)=> locator<HomeBloc>()), 
        BlocProvider<BookmarkBloc>(create:(context)=> locator<BookmarkBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: RoootScreen(),
      ),
    );
  }
}
