import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/home/presentation/bindings/home_bindings.dart';
import 'package:movie_app/home/presentation/screens/home.dart';
import 'package:movie_app/main_binding.dart';
import 'package:movie_app/tv_shows/presentation/bindings/tv_list_bindings.dart';
import 'package:movie_app/tv_shows/presentation/screen/tv_shows.dart';
import 'core/constants/route_constants.dart';
import 'movies/presentation/bindings/movie_list_bindings.dart';
import 'movies/presentation/screen/movies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: pages,
      initialBinding: MainBinding(),
      initialRoute: HOME_ROUTE,
    );
  }

  final pages = [
    GetPage(
        name: MOVIES_ROUTE,
        page: () => MoviesScreen(),
        binding: MovieListBindings()),
    GetPage(
        name: TV_SHOWS_ROUTE,
        page: () => TvShowsScreen(),
        binding: TvListBindings()),
    GetPage(name: HOME_ROUTE, page: () => HomeScreen(), binding: HomeBindings())
  ];
}
