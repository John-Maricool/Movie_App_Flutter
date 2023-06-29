import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/domain/usecases/home_category_usecase.dart';
import 'package:movie_app/home/presentation/controller/home_controller.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';

import 'home_controller_test.mocks.dart';

class HomeCategoryUsecaseTest extends Mock implements HomeCategoryUsecase {}

class MovieDetailUsecaseTest extends Mock implements MovieDetailUsecase {}

@GenerateMocks([HomeCategoryUsecaseTest, MovieDetailUsecaseTest])
void main() {
  late HomeControllerImpl controller;
  late MockHomeCategoryUsecaseTest mockHomeCategoryUsecase;
  late MockMovieDetailUsecaseTest mockMovieDetailUsecase;

  final testMovies = [
    MovieListItemModel(id: 1, title: "title", image: "image"),
    MovieListItemModel(id: 2, title: "title", image: "image"),
  ];
  setUp(() {
    mockHomeCategoryUsecase = MockHomeCategoryUsecaseTest();
    mockMovieDetailUsecase = MockMovieDetailUsecaseTest();
    controller = HomeControllerImpl(
      usecase: mockHomeCategoryUsecase,
      detailUsecase: mockMovieDetailUsecase,
    );
  });
  group('Testing the popular movies function', () {
    final testMovieDetail = MovieDetail(
        id: 1,
        poster_path: "poster_path",
        backdrop_path: "backdrop_path",
        title: "title",
        vote_count: 2,
        vote_average: 3,
        original_language: "original_language",
        release_date: "release_date",
        runtime: 3,
        genres: [],
        overview: "overview");
    test(
        'getPopularMovies should update data1 and set finished state on success. Also make sure the details is gotten',
        () {
      // Mock the usecase and its behavior
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "popular",
        any,
      )).thenAnswer((invocation) {
        expect(controller.state1, isA<LoadingState>());
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testMovies)));
      });

      when(mockMovieDetailUsecase.getMovieDetail(1, any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<MovieDetail>>(
            Result(value: testMovieDetail)));
      });

      // Invoke the method
      controller.getPopularMovies();

      // Verify the expected changes
      expect(controller.data1.isEmpty, false);
      expect(controller.data1.length, 2);
      expect(controller.state1, isA<FinishedState>());
      verify(mockMovieDetailUsecase.getMovieDetail(1, any));
      expect(controller.stateDetail, isA<FinishedState>());
    });

    test('getPopularMovies should set error state on failure', () {
      // Mock the usecase and its behavior
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "popular",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: ServerError())));
      });

      // Invoke the method
      controller.getPopularMovies();

      expect(controller.state1, isA<ErrorState>());
      expect(
          (controller.state1 as ErrorState).errorType, equals(ServerError()));
    });
  });

  group('Testing the upcoming movies function', () {
    test(
        'getUpcomingMovies should update data2 and set finished state on success. Also make sure the details is gotten',
        () {
      // Mock the usecase and its behavior
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "upcoming",
        any,
      )).thenAnswer((invocation) {
        expect(controller.state2, isA<LoadingState>());

        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testMovies)));
      });

      // Invoke the method
      controller.getUpcomingMovies();

      // Verify the expected changes
      expect(controller.data2.isEmpty, false);
      expect(controller.data2.length, 2);
      expect(controller.state2, isA<FinishedState>());
    });

    test('getUpcoming should set error state on failure', () {
      // Mock the usecase and its behavior
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "upcoming",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: ServerError())));
      });

      // Invoke the method
      controller.getUpcomingMovies();

      expect(controller.state2, isA<ErrorState>());
      expect(
          (controller.state2 as ErrorState).errorType, equals(ServerError()));
    });
  });

  group('Testing the Top rated  movies function', () {
    test(
        'getTopRatedMovies should update data3 and set finished state on success. Also make sure the details is gotten',
        () {
      // Mock the usecase and its behavior
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "top_rated",
        any,
      )).thenAnswer((invocation) {
        expect(controller.state3, isA<LoadingState>());
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testMovies)));
      });

      // Invoke the method
      controller.getTopRatedMovies();

      // Verify the expected changes
      expect(controller.data3.isEmpty, false);
      expect(controller.data3.length, 2);
      expect(controller.state3, isA<FinishedState>());
    });

    test('getUpcoming should set error state on failure', () {
      // Mock the usecase and its behavior
      when(mockHomeCategoryUsecase.getMovieCategory(
        1,
        "top_rated",
        any,
      )).thenAnswer((invocation) {
        // Simulate an error response
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: ServerError())));
      });

      // Invoke the method
      controller.getTopRatedMovies();

      expect(controller.state3, isA<ErrorState>());
      expect(
          (controller.state3 as ErrorState).errorType, equals(ServerError()));
    });
  });
}
