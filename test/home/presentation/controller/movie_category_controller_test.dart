import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/presentation/controller/movie_category_controller.dart';
import 'home_controller_test.mocks.dart';

void main() {
  late MockHomeCategoryUsecaseTest mockHomeCategoryUsecase;
  late MovieCategoryController controller;

  setUp(() {
    mockHomeCategoryUsecase = MockHomeCategoryUsecaseTest();
    controller = MovieCategoryController(usecase: mockHomeCategoryUsecase);
  });

  group('MovieCategoryController', () {
    final expectedMovies = [
      MovieListItemModel(id: 1, title: 'Movie 1', image: 'imaga'),
      MovieListItemModel(id: 2, title: 'Movie 2', image: "image"),
    ];

    test(
        'getMovieCategory should update data1 and set finished state on success',
        () {
      when(mockHomeCategoryUsecase.getMovieCategory(1, "popular", any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
          Result(value: expectedMovies),
        ));
      });

      expect(controller.currentPage.value, equals(1));

      // Act
      controller.getMovieCategory("popular");

      // Assert
      verify(mockHomeCategoryUsecase.getMovieCategory(1, "popular", any))
          .called(1);
      expect(controller.data1, equals(expectedMovies));
      expect(controller.state1, isA<FinishedState>());
      expect(controller.currentPage.value, equals(2));
    });

    test('getMovieCategory should update state1 with error state on failure',
        () {
      // Arrange
      final expectedError = Failure(error: ServerError());

      when(mockHomeCategoryUsecase.getMovieCategory(1, "popular", any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
          expectedError,
        ));
      });
      expect(controller.currentPage.value, equals(1));

      // Act
      controller.getMovieCategory("popular");

      // Assert
      verify(mockHomeCategoryUsecase.getMovieCategory(1, "popular", any))
          .called(1);
      expect(controller.state1, isA<ErrorState>());
      expect(
          (controller.state1 as ErrorState).errorType, equals(ServerError()));
      expect(controller.currentPage.value, equals(1));
    });

    test('fetchItems should add new items to data1 and update currentPage', () {
      // Arrange
      controller.data1.addAll(expectedMovies);
      final newMovies = [
        MovieListItemModel(id: 3, title: 'Movie 3', image: "image"),
        MovieListItemModel(id: 4, title: 'Movie 4', image: "image"),
      ];

      when(mockHomeCategoryUsecase.getMovieCategory(1, "popular", any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[2];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
          Result(value: newMovies),
        ));
      });
      expect(controller.currentPage.value, equals(1));

      // Act
      controller.fetchItems("popular");

      // Assert
      expect(controller.currentPage.value, equals(2));
      expect(controller.data1, equals([...expectedMovies, ...newMovies]));
      expect(controller.isLast.value, false);
    });

    test('fetchItems should not add new items to data1 and update currentPage',
        () {
      // Arrange
      controller.data1.addAll(expectedMovies);

      when(mockHomeCategoryUsecase.getMovieCategory(1, "popular", any))
          .thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[2];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
          Failure(error: ServerError()),
        ));
      });
      expect(controller.currentPage.value, equals(1));

      // Act
      controller.fetchItems("popular");

      // Assert
      expect(controller.currentPage.value, equals(1));
      expect(controller.data1, equals(expectedMovies));
      expect(controller.isLast.value, true);
    });
  });
}
