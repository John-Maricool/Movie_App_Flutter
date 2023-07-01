import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/presentation/controller/movie_detail_controller.dart';
import 'package:movie_app/movie_detail/presentation/screens/movie_detail.dart';

import '../controller/movie_detail_controller_test.mocks.dart';
import 'movie_detail_test.mocks.dart';

class MovieDetailControllerText extends Mock implements MovieDetailController {}

class BuildContextTest extends Mock implements BuildContext {}

@GenerateNiceMocks([MockSpec<BuildContextTest>()])
void main() {
  late MovieDetailController controller;
  late MockMovieDetailUsecaseTest mockMovieDetailUsecaseTest;
  late MockBuildContextTest context;
  final testCasts = [
    Cast(
        id: 2,
        name: "name",
        profile_path: "profile_path",
        known_for_department: "known_for_department"),
    Cast(
        id: 3,
        name: "name",
        profile_path: "profile_path",
        known_for_department: "known_for_department"),
  ];

  final testVideos = [
    Video(id: "id", name: "name", key: "key"),
    Video(id: "id", name: "name", key: "key"),
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

  group("Testing the movie detail function", () {
    setUp(() {
      mockMovieDetailUsecaseTest = MockMovieDetailUsecaseTest();
      controller =
          Get.put(MovieDetailController(usecase: mockMovieDetailUsecaseTest));
      Get.testMode = true;
      final mockArgs = MovieDetailArgument(0, "");
      context = MockBuildContextTest();

      // final args = Get.arguments as MovieDetailArgument;
    });

    tearDown(() {
      Get.delete<MovieDetailController>();
    });
    testWidgets('movie detail ...', (tester) async {
      when(mockMovieDetailUsecaseTest.getMovieDetail(1, any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<MovieDetail>>(
            Result(value: testMovieDetail)));
      });
      controller.getMovieDetail(1);

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: MovieDetailScreen().movieDetails(context)),
          ),
        );
      });
      //    expect(find.byType(CircularProgressIndicator), findsNothing);
      // /  expect(find.byWidget(noInternet(() {})), findsNothing);
    });
  });
}
