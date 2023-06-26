import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/repo/tv_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/usecases/tv_detail_usecase.dart';

import 'tv_detail_usecase_test.mocks.dart';

class TvDetailRepoTest extends Mock implements TvDetailRepo {}

@GenerateMocks([TvDetailRepoTest])
void main() {
  MockTvDetailRepoTest repository = MockTvDetailRepoTest();
  TvDetailUsecaseImpl usecase = TvDetailUsecaseImpl(repo: repository);

  group("Check for return of movie details", () {
    test("Testing if the usecase returns right as repo", () {
      when(repository.getTvDetail("tv", 1)).thenAnswer((_) => Future(() =>
          Right(Result(
              value: TvDetail(
                  id: 2,
                  poster_path: "poster_path",
                  backdrop_path: "backdrop_path",
                  original_name: "original_name",
                  vote_count: 2,
                  number_of_episodes: 2,
                  vote_average: 2,
                  number_of_seasons: 2,
                  first_air_date: "first_air_date",
                  genres: [],
                  overview: "overview")))));

      usecase.getMovieDetail(1, (b) {
        expect(b.isRight, true);
        expect(b.isLeft, false);
      });
    });

    test("Testing if the usecase returns left as repo", () {
      when(repository.getTvCasts("tv", 1))
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
      when(repository.getTvCasts("tv", 1))
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
      when(repository.getTvCasts("tv", 1))
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
      when(repository.getTvVideos("tv", 1))
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
      when(repository.getTvVideos("movie", 1))
          .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

      usecase.getMovieVideos(1, (b) {
        expect(b.isRight, false);
        expect(b.isLeft, true);
        expect(b.left.error, equals(ServerError()));
      });
    });
  });
}
