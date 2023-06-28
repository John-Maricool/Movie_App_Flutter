import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/movie_detail/domain/usecases/tv_detail_usecase.dart';
import 'package:movie_app/movie_detail/presentation/controller/movie_detail_controller.dart';
import 'package:movie_app/movie_detail/presentation/controller/tv_detail_controller.dart';

import '../../../home/presentation/controller/home_controller_test.mocks.dart';
import 'tv_detail_controller_test.mocks.dart';

class TvDetailUsecaseTest extends Mock implements TvDetailUsecaseImpl {}

@GenerateMocks([TvDetailUsecaseTest])
void main() {
  late TvDetailController controller;
  late MockTvDetailUsecaseTest mockUsecase;

  setUp(() {
    mockUsecase = MockTvDetailUsecaseTest();
    controller = TvDetailController(usecase: mockUsecase);
  });
  const movieId = 123;
  final dummyCasts = [
    Cast(
        id: 1,
        name: "name",
        profile_path: "profile_path",
        known_for_department: "known_for_department"),
    Cast(
        id: 2,
        name: "name",
        profile_path: "profile_path",
        known_for_department: "known_for_department"),
  ];
  final dummyVideos = [
    Video(id: "2", name: "name", key: "key"),
    Video(id: "3", name: "name", key: "key"),
  ];
  final dummyDetail = TvDetail(
      id: 2,
      poster_path: "poster_path",
      backdrop_path: "backdrop_path",
      original_name: "original_name",
      vote_count: 2,
      number_of_episodes: 3,
      vote_average: 4,
      number_of_seasons: 5,
      first_air_date: "first_air_date",
      genres: [],
      overview: "overview");
  group('Movie Detail Controller Tests', () {
    test('Initial state values should be correct', () {
      expect(controller.data1, isEmpty);
      expect(controller.data2, isEmpty);
      expect(controller.detail, TvDetail.empty());
      expect(controller.state1, isInstanceOf<State>());
      expect(controller.state2, isInstanceOf<State>());
      expect(controller.stateDetail, isInstanceOf<State>());
    });

    test('Set ID should fetch movie detail, casts, and videos', () {
      const movieId = 123;
      final dummyCasts = [
        Cast(
            id: 1,
            name: "name",
            profile_path: "profile_path",
            known_for_department: "known_for_department"),
        Cast(
            id: 2,
            name: "name",
            profile_path: "profile_path",
            known_for_department: "known_for_department"),
      ];
      final dummyVideos = [
        Video(id: "2", name: "name", key: "key"),
        Video(id: "3", name: "name", key: "key"),
      ];
      final dummyDetail = TvDetail(
          id: 2,
          poster_path: "poster_path",
          backdrop_path: "backdrop_path",
          original_name: "original_name",
          vote_count: 2,
          number_of_episodes: 3,
          vote_average: 4,
          number_of_seasons: 5,
          first_air_date: "first_air_date",
          genres: [],
          overview: "overview");

      when(mockUsecase.getMovieCasts(movieId, any)).thenAnswer((invocation) {
        expect(controller.state1, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<List<Cast>>>(Result(value: dummyCasts)));
      });
      when(mockUsecase.getMovieVideos(movieId, any)).thenAnswer((invocation) {
        expect(controller.state2, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(
            Right<Failure, Result<List<Video>>>(Result(value: dummyVideos)));
      });
      when(mockUsecase.getMovieDetail(movieId, any)).thenAnswer((invocation) {
        expect(controller.stateDetail, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<TvDetail>>(Result(value: dummyDetail)));
      });

      controller.setId(movieId);

      verify(mockUsecase.getMovieCasts(movieId, any));
      verify(mockUsecase.getMovieVideos(movieId, any));
      verify(mockUsecase.getMovieDetail(movieId, any));

      expect(controller.data1, equals(dummyCasts));
      expect(controller.state1, isA<FinishedState>());

      expect(controller.data2, dummyVideos);
      expect(controller.state2, isA<FinishedState>());

      expect(controller.detail, dummyDetail);
      expect(controller.stateDetail, isA<FinishedState>());
    });

    test('Set ID should fetch movie detail, error casts, and videos', () {
      when(mockUsecase.getMovieCasts(movieId, any)).thenAnswer((invocation) {
        expect(controller.state1, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(
            Left<Failure, Result<List<Cast>>>(Failure(error: ServerError())));
      });
      when(mockUsecase.getMovieVideos(movieId, any)).thenAnswer((invocation) {
        expect(controller.state2, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(
            Right<Failure, Result<List<Video>>>(Result(value: dummyVideos)));
      });
      when(mockUsecase.getMovieDetail(movieId, any)).thenAnswer((invocation) {
        expect(controller.stateDetail, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<TvDetail>>(Result(value: dummyDetail)));
      });

      controller.setId(movieId);

      verify(mockUsecase.getMovieCasts(movieId, any));
      verify(mockUsecase.getMovieVideos(movieId, any));
      verify(mockUsecase.getMovieDetail(movieId, any));

      expect((controller.state1 as ErrorState).errorType, ServerError());
      expect(controller.state1, isA<ErrorState>());

      expect(controller.data2, dummyVideos);
      expect(controller.state2, isA<FinishedState>());

      expect(controller.detail, dummyDetail);
      expect(controller.stateDetail, isA<FinishedState>());
    });
  });
}
