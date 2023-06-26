import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/movies/data/datasources/movie_list_datasource.dart';
import 'package:movie_app/movies/domain/repository/movie_list_repository.dart';
import 'package:movie_app/tv_shows/data/datosource/tv_list_datasource.dart';
import 'package:movie_app/tv_shows/domain/repo/tv_list_repo.dart';

import '../../../home/domain/repo/home_repository_test.mocks.dart';
import 'tv_list_repo_test.mocks.dart';

class TvListDataSourceTest extends Mock implements TvListDataSource {}

@GenerateMocks([TvListDataSourceTest])
void main() {
  const page = 2;
  final movieList = [
    MovieListItemModel(id: 1, title: 'Movie 1', image: ""),
    MovieListItemModel(id: 2, title: 'Movie 2', image: ""),
  ];

  late TvListRepository repository;
  late MockTvListDataSourceTest mockDataSource;
  late MockNetworkInfoTest mockNetworkInfo;

  setUp(() {
    mockDataSource = MockTvListDataSourceTest();
    mockNetworkInfo = MockNetworkInfoTest();
    repository =
        TvListRepositoryImpl(datasource: mockDataSource, info: mockNetworkInfo);
  });

  test("Testing if the Either right is returned with list of movies", () async {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockDataSource.getMovies(page)).thenAnswer((_) async => movieList);

    // Call the repository method
    final result = await repository.getMovies(page);

    // Verify the result
    expect(result.isRight, true);
    expect(result.isLeft, false);
    expect(result.right.value, movieList);
    // Verify the mock invocations
    verify(mockNetworkInfo.isConnected);
    verify(mockDataSource.getMovies(page));
    verifyNoMoreInteractions(mockDataSource);
  });

  test('should return a ServerError when an exception is thrown', () async {
    // Set up mock behavior
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    when(mockDataSource.getMovies(page)).thenThrow(Exception());

    // Call the repository method
    final result = await repository.getMovies(page);

    // Verify the result
    expect(result.isLeft, true);
    expect(result.isRight, false);
    expect(result.left.error, equals(ServerError()));
    // Verify the mock invocations
    verify(mockNetworkInfo.isConnected);
    verify(mockDataSource.getMovies(page));
    verifyNoMoreInteractions(mockDataSource);
  });

  test('should return an InternetError when the network is disconnected',
      () async {
    // Set up mock behavior
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

    // Call the repository method
    final result = await repository.getMovies(page);

    // Verify the result
    expect(result.isLeft, true);
    expect(result.isRight, false);

    expect(result.left.error, equals(InternetError()));
    // Verify the mock invocations
    verify(mockNetworkInfo.isConnected);
    verifyZeroInteractions(mockDataSource);
  });
}
