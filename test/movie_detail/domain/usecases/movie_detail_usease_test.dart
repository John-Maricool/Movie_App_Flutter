import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';

import 'movie_detail_usease_test.mocks.dart';

class MovieDetailRepoTest extends Mock implements MovieDetailRepo {}

@GenerateMocks([MovieDetailRepoTest])
void main() {
  MockMovieDetailRepoTest repository = MockMovieDetailRepoTest();
  MovieDetailUsecase usecase = MovieDetailUsecaseImpl(repo: repository);

  group("Check for return of movie details", () {
    test("Testing if the usecase returns right as repo", () {
      when(repository.getMovieDetail("movie", 1)).thenAnswer((_) => Future(() =>
          Right(Result(
              value: MovieDetail(
                  id: 1,
                  poster_path: "poster_path",
                  backdrop_path: "backdrop_path",
                  title: "title",
                  vote_count: 1,
                  vote_average: 12,
                  original_language: "original_language",
                  release_date: "release_date",
                  runtime: 2,
                  genres: [],
                  overview: "overview")))));

      usecase.getMovieDetail(1, (b) {
        expect(b.isRight, true);
        expect(b.isLeft, false);
      });
    });

    test("Testing if the usecase returns left as repo", () {
      when(repository.getMovieDetail("movie", 1))
          .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

      usecase.getMovieDetail(1, (b) {
        expect(b.isRight, false);
        expect(b.isLeft, true);
        expect(b.left.error, equals(ServerError()));
      });
    });
  });

  group("Check for return of casts", () {
    test("Testing if the usecase returns right as repo", () {
      when(repository.getMovieCasts("movie", 1))
          .thenAnswer((_) => Future(() => Right(Result(value: [
                Cast(
                    id: 12,
                    name: "name",
                    profile_path: "profile_path",
                    known_for_department: "known_for_department"),
                Cast(
                    id: 12,
                    name: "name",
                    profile_path: "profile_path",
                    known_for_department: "known_for_department"),
              ]))));

      usecase.getMovieCasts(1, (b) {
        expect(b.isRight, true);
        expect(b.isLeft, false);
        expect(b.right.value.length, 2);
      });
    });

    test("Testing if the usecase returns left as repo", () {
      when(repository.getMovieCasts("movie", 1))
          .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

      usecase.getMovieCasts(1, (b) {
        expect(b.isRight, false);
        expect(b.isLeft, true);
        expect(b.left.error, equals(ServerError()));
      });
    });
  });

  group("Check for return of video", () {
    test("Testing if the usecase returns right as repo", () {
      when(repository.getMovieVideos("movie", 1))
          .thenAnswer((_) => Future(() => Right(Result(value: [
                Video(id: "2", name: "name", key: "key"),
                Video(id: "2", name: "name", key: "key")
              ]))));

      usecase.getMovieVideos(1, (b) {
        expect(b.isRight, true);
        expect(b.isLeft, false);
        expect(b.right.value.length, 2);
      });
    });

    test("Testing if the usecase returns left as repo", () {
      when(repository.getMovieVideos("movie", 1))
          .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

      usecase.getMovieVideos(1, (b) {
        expect(b.isRight, false);
        expect(b.isLeft, true);
        expect(b.left.error, equals(ServerError()));
      });
    });
  });
}
