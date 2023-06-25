import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/home/domain/repo/home_repository.dart';
import 'package:movie_app/home/domain/usecases/home_category_usecase.dart';
import 'home_category_usecase_test.mocks.dart';

class HomeRepositoryTest extends Mock implements HomeRepository {}

@GenerateMocks([HomeRepositoryTest])
void main() {
  MockHomeRepositoryTest repository = MockHomeRepositoryTest();
  HomeCategoryUsecase usecase = HomeCategoryUsecase(repo: repository);

  test("Testing if the usecase returns right as repo", () {
    when(repository.getMovieCategory("popular", 1))
        .thenAnswer((_) => Future(() => Right(Result(value: []))));

    usecase.getMovieCategory(1, 'popular', (b) {
      expect(b.isRight, true);
      expect(b.isLeft, false);
    });
  });

  test("Testing if the usecase returns left as repo", () {
    when(repository.getMovieCategory("popular", 1))
        .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

    usecase.getMovieCategory(1, 'popular', (b) {
      expect(b.isRight, false);
      expect(b.isLeft, true);
      expect(b.left.error, equals(ServerError()));
    });
  });
}
