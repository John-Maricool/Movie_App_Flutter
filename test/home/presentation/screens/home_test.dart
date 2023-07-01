import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/presentation/controller/home_controller.dart';
import 'package:movie_app/home/presentation/screens/home.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';

import '../controller/home_controller_test.mocks.dart';

class HomeControllerTest extends Mock implements HomeController {}

@GenerateMocks([HomeControllerTest])
void main() {
  late MockHomeCategoryUsecaseTest mockHomeCategoryUsecase;
  late HomeControllerImpl controller;
  late MockMovieDetailUsecaseTest mockMovieDetailUsecaseTest;
  final testMovies = [
    MovieListItemModel(id: 1, title: "title", image: "image"),
    MovieListItemModel(id: 2, title: "title", image: "image"),
  ];

  final testMovieDetail = MovieDetail(
      id: 2,
      poster_path: "poster_path",
      backdrop_path: "backdrop_path",
      title: "title",
      vote_count: 2,
      vote_average: 3,
      original_language: "original_language",
      release_date: "release_date",
      runtime: 2,
      genres: [],
      overview: "overview");

  group('Testing Popular movies widget', () {
    setUp(() {
      mockHomeCategoryUsecase = MockHomeCategoryUsecaseTest();
      mockMovieDetailUsecaseTest = MockMovieDetailUsecaseTest();

      controller = Get.put(HomeControllerImpl(
          usecase: mockHomeCategoryUsecase,
          detailUsecase: mockMovieDetailUsecaseTest));
    });

    tearDown(() {
      Get.delete<HomeControllerImpl>();
    });

    testWidgets('Widget renders correctly in finished state',
        (WidgetTester tester) async {
      when(mockMovieDetailUsecaseTest.getMovieDetail(1, any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<MovieDetail>>(
            Result(value: testMovieDetail)));
      });

      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "popular",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testMovies)));
      });

      controller.getPopularMovies();

      // Build the widget with the mock controller
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: HomeScreen().popular(controller)),
          ),
        );
      });

      // Verify that the widget renders the expected UI elements
      expect(find.text('Popular'), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(testMovies.length));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byWidget(noInternet(() {})), findsNothing);
    });

    testWidgets('Widget renders in error state', (WidgetTester tester) async {
      when(mockMovieDetailUsecaseTest.getMovieDetail(1, any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[1];
        callback(
            Left<Failure, Result<MovieDetail>>(Failure(error: ServerError())));
      });

      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "popular",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: InternetError())));
      });

      controller.getPopularMovies();

      // Build the widget with the mock controller
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: HomeScreen().popular(controller)),
          ),
        );
      });

      // Verify that the widget renders the expected UI elements
      expect(find.text('Popular'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
      expect(find.byKey(Key("progress_bar")), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(controller.state1, ErrorState(errorType: InternetError()));
      expect(find.byKey(Key("no_internet")), findsOneWidget);
    });
  });

  group('Testing in theatre movies widget', () {
    setUp(() {
      mockHomeCategoryUsecase = MockHomeCategoryUsecaseTest();
      mockMovieDetailUsecaseTest = MockMovieDetailUsecaseTest();

      controller = Get.put(HomeControllerImpl(
          usecase: mockHomeCategoryUsecase,
          detailUsecase: mockMovieDetailUsecaseTest));
    });

    tearDown(() {
      Get.delete<HomeControllerImpl>();
    });

    testWidgets('Widget renders correctly in finished state',
        (WidgetTester tester) async {
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "upcoming",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testMovies)));
      });

      controller.getUpcomingMovies();

      // Build the widget with the mock controller
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: HomeScreen().inTheatre()),
          ),
        );
      });

      // Verify that the widget renders the expected UI elements
      expect(find.text('In Theatre'), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(testMovies.length));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byWidget(noInternet(() {})), findsNothing);
    });

    testWidgets('Widget renders in error state', (WidgetTester tester) async {
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "upcoming",
        any,
      )).thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: InternetError())));
      });

      controller.getUpcomingMovies();

      // Build the widget with the mock controller
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: HomeScreen().inTheatre()),
          ),
        );
      });

      // Verify that the widget renders the expected UI elements
      expect(find.text('In Theatre'), findsOneWidget);
      expect(find.byKey(Key("single_list")), findsNothing);
      expect(find.byKey(Key("progress_bar")), findsNothing);
      expect(controller.state2, equals(ErrorState(errorType: InternetError())));
      expect(find.byKey(Key("no_internet")), findsOneWidget);
    });
  });

  group('Testing top rated movies widget', () {
    setUp(() {
      mockHomeCategoryUsecase = MockHomeCategoryUsecaseTest();
      mockMovieDetailUsecaseTest = MockMovieDetailUsecaseTest();

      controller = Get.put(HomeControllerImpl(
          usecase: mockHomeCategoryUsecase,
          detailUsecase: mockMovieDetailUsecaseTest));
    });

    tearDown(() {
      Get.delete<HomeControllerImpl>();
    });

    testWidgets('Widget renders correctly in finished state',
        (WidgetTester tester) async {
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "top_rated",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testMovies)));
      });

      controller.getTopRatedMovies();

      // Build the widget with the mock controller
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: HomeScreen().topRated()),
          ),
        );
      });

      // Verify that the widget renders the expected UI elements
      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.byType(Image), findsNWidgets(testMovies.length));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byWidget(noInternet(() {})), findsNothing);
    });

    testWidgets('Widget renders in error state', (WidgetTester tester) async {
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "top_rated",
        any,
      )).thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: InternetError())));
      });

      controller.getTopRatedMovies();

      // Build the widget with the mock controller
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: HomeScreen().topRated()),
          ),
        );
      });

      // Verify that the widget renders the expected UI elements
      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.byKey(Key("single_list")), findsNothing);
      expect(find.byKey(Key("progress_bar")), findsNothing);
      expect(controller.state3, equals(ErrorState(errorType: InternetError())));
      expect(find.byKey(Key("no_internet")), findsOneWidget);
    });
  });
}
