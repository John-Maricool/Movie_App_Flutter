import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';
import 'package:movie_app/single_cast_detail/domain/repositories/single_cast_deetails_repo.dart';
import 'package:movie_app/single_cast_detail/domain/usecases/single_cast_details_usecase.dart';
import 'single_cast_details_usecase_test.mocks.dart';

class SingleCastDetailsRepoTest extends Mock implements SingleCastDetailsRepo {}

@GenerateMocks([SingleCastDetailsRepoTest])
void main() {
  MockSingleCastDetailsRepoTest repository = MockSingleCastDetailsRepoTest();
  SingleCastDetailsUsecase usecase = SingleCastDetailsUsecase(repo: repository);

  group("Check for return of movie details", () {
    final singleCast = SingleCastModel(
        image: "image",
        name: "name",
        role: "role",
        desc: "desc",
        images: [],
        movie: []);
    test("Testing if the usecase returns right as repo", () {
      when(repository.getCastDetails(1))
          .thenAnswer((_) => Future(() => Right(Result(value: singleCast))));

      usecase.getCastDetails(1, (b) {
        expect(b.isRight, true);
        expect(b.isLeft, false);
        expect(b.right.value, singleCast);
      });
    });

    test("Testing if the usecase returns left as repo", () {
      when(repository.getCastDetails(1))
          .thenAnswer((_) => Future(() => Left(Failure(error: ServerError()))));

      usecase.getCastDetails(1, (b) {
        expect(b.isRight, false);
        expect(b.isLeft, true);
        expect(b.left.error, equals(ServerError()));
      });
    });
  });
}
