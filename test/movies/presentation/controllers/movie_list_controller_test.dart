import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/movies/domain/usecase/movie_list_usecase.dart';
import 'package:movie_app/movies/presentation/controllers/movie_list_controller.dart';

import 'movie_list_controller_test.mocks.dart';

class MovieListUsecaseTest extends Mock implements MovieListUsecase {}

@GenerateMocks([MovieListUsecaseTest])
void main() {
  late MovieListController controller;
  late MockMovieListUsecaseTest movieListUsecaseTest;
  final testResult = [
    MovieListItemModel(id: 1, title: "title", image: "image"),
    MovieListItemModel(id: 2, title: "title", image: "image"),
    MovieListItemModel(id: 3, title: "title", image: "image"),
    MovieListItemModel(id: 4, title: "title", image: "image"),
  ];

  setUp(() {
    movieListUsecaseTest = MockMovieListUsecaseTest();
    controller = MovieListController(usecase: movieListUsecaseTest);
  });

  group("Testing the movie list controller getmovies", () {
    test("Verify everything is default", () {
      expect(controller.currentPage.value, 1);
      expect(controller.data, isEmpty);
      expect(controller.isLast.value, false);
      expect(controller.state, isInstanceOf<State>());
    });

    test("Testing the getMovies function", () {
      when(movieListUsecaseTest.getMovies(1, any)).thenAnswer((invocation) {
        expect(controller.state, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: testResult)));
      });
      expect(controller.currentPage.value, 1);
      controller.getMovies();

      // Verify the expected changes
      expect(controller.data.isEmpty, false);
      expect(controller.data.length, 4);
      expect(controller.state, isA<FinishedState>());
      expect(controller.currentPage.value, 2);
      verify(movieListUsecaseTest.getMovies(1, any));
    });

    test("Testing the getMovies function and getting error", () {
      when(movieListUsecaseTest.getMovies(1, any)).thenAnswer((invocation) {
        expect(controller.state, isA<LoadingState>());
        Function callback = invocation.positionalArguments[1];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: InternetError())));
      });
      expect(controller.currentPage.value, 1);
      controller.getMovies();

      // Verify the expected changes
      expect(controller.data.isEmpty, true);
      expect(controller.state, isA<ErrorState>());
      expect((controller.state as ErrorState).errorType, isA<InternetError>());
      expect(controller.currentPage.value, 1);
      verify(movieListUsecaseTest.getMovies(1, any));
    });

    test("Testing for getting more movies", () {
      final newResults = [
        MovieListItemModel(id: 5, title: "title", image: "image"),
        MovieListItemModel(id: 6, title: "title", image: "image"),
        MovieListItemModel(id: 7, title: "title", image: "image"),
        MovieListItemModel(id: 8, title: "title", image: "image"),
      ];

      controller.data.addAll(testResult);

      when(movieListUsecaseTest.getMovies(1, any)).thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[1];
        callback(Right<Failure, Result<List<MovieListItemModel>>>(
            Result(value: newResults)));
      });
      expect(controller.currentPage.value, 1);
      controller.fetchItems();

      expect(controller.data.isEmpty, false);
      expect(controller.data.length, 8);
      expect(controller.currentPage.value, 2);
      expect(controller.isLast.value, false);
      verify(movieListUsecaseTest.getMovies(1, any));
    });

    test("Testing for getting more movies error", () {
      controller.data.addAll(testResult);

      when(movieListUsecaseTest.getMovies(1, any)).thenAnswer((invocation) {
        Function callback = invocation.positionalArguments[1];
        callback(Left<Failure, Result<List<MovieListItemModel>>>(
            Failure(error: ServerError())));
      });
      expect(controller.currentPage.value, 1);
      controller.fetchItems();

      expect(controller.data.isEmpty, false);
      expect(controller.data.length, 4);
      expect(controller.currentPage.value, 1);
      expect(controller.isLast.value, true);
      verify(movieListUsecaseTest.getMovies(1, any));
    });
  });
}
