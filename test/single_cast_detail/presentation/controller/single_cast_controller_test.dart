import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';
import 'package:movie_app/single_cast_detail/domain/usecases/single_cast_details_usecase.dart';
import 'package:movie_app/single_cast_detail/presentation/controller/single_cast_controller.dart';

import 'single_cast_controller_test.mocks.dart';

class SingleCastDetailsUsecaseTest extends Mock
    implements SingleCastDetailsUsecase {}

@GenerateMocks([SingleCastDetailsUsecaseTest])
void main() {
  late SingleCastController controller;
  late MockSingleCastDetailsUsecaseTest mockUsecase;

  setUp(() {
    mockUsecase = MockSingleCastDetailsUsecaseTest();
    controller = SingleCastController(usecase: mockUsecase);
  });

  group('Cast Controller Tests', () {
    test('Initial state values should be correct', () {
      expect(controller.detail, SingleCastModel.empty());
      expect(controller.stateDetail, isInstanceOf<State>());
    });

    test('Set ID should fetch movie detail, casts, and videos', () {
      const movieId = 123;
      final dummyDetail = SingleCastModel(
          image: "image", name: "name", desc: "desc", images: [], movie: []);

      when(mockUsecase.getCastDetails(movieId, any)).thenAnswer((invocation) {
        expect(controller.stateDetail, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<SingleCastModel>>(
            Result(value: dummyDetail)));
      });

      controller.setId(movieId);

      verify(mockUsecase.getCastDetails(movieId, any));
      expect(controller.detail, dummyDetail);
      expect(controller.stateDetail, isA<FinishedState>());
    });

    test('Set ID should fetch error movie detail', () {
      const movieId = 123;

      when(mockUsecase.getCastDetails(movieId, any)).thenAnswer((invocation) {
        expect(controller.stateDetail, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Left<Failure, Result<SingleCastModel>>(
            Failure(error: ServerError())));
      });

      controller.setId(movieId);

      verify(mockUsecase.getCastDetails(movieId, any));

      expect(controller.detail, SingleCastModel.empty());
      expect(controller.stateDetail, isA<ErrorState>());
      expect(
          (controller.stateDetail as ErrorState).errorType, isA<ServerError>());
    });
  });
}
