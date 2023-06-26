import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movies/domain/repository/movie_list_repository.dart';
import 'package:movie_app/movies/domain/usecase/movie_list_usecase.dart';

import 'movie_list_usecase_test.mocks.dart';

class MovieListRepositoryTest extends Mock implements MovieListRepository {}

@GenerateMocks([MovieListRepositoryTest])
void main() {
  MockMovieListRepositoryTest repository = MockMovieListRepositoryTest();
  MovieListUsecase usecase = MovieListUsecase(repo: repository);

  test("Testing if the usecase returns right as repo", () {
    when(repository.getMovies(1))
        .thenAnswer((_) => Future(() => Right(Result(value: []))));

    usecase.getMovies(1, (b) {
      expect(b.isRight, true);
      expect(b.isLeft, false);
    });
  });

  test("Testing if the usecase returns left as repo", () {
    when(repository.getMovies(1))
        .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

    usecase.getMovies(1, (b) {
      expect(b.isRight, false);
      expect(b.isLeft, true);
      expect(b.left.error, equals(ServerError()));
    });
  });
}
