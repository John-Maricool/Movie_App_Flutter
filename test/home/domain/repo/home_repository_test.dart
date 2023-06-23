import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/home/data/datasources/home_data_source.dart';
import 'package:movie_app/home/domain/repo/home_repository.dart';

import 'home_repository_test.mocks.dart';

class HomeDataSourceTest extends Mock implements HomeDataSource {}

class NetworkInfoTest extends Mock implements NetworkInfo {}

@GenerateMocks([HomeDataSourceTest])
@GenerateMocks([NetworkInfoTest])
void main() {
  late HomeRepository repository;
  late MockHomeDataSourceTest mockDataSource;
  late MockNetworkInfoTest mockNetworkInfo;

  setUp(() {
    mockDataSource = MockHomeDataSourceTest();
    mockNetworkInfo = MockNetworkInfoTest();
    repository =
        HomeRepositoryImpl(datasource: mockDataSource, info: mockNetworkInfo);
  });

  group('getMovieCategory', () {
    const category = 'popular';
    const page = 1;
    final movieList = [
      MovieListItemModel(id: 1, title: 'Movie 1', image: ""),
      MovieListItemModel(id: 2, title: 'Movie 2', image: ""),
    ];

    test('should return a list of movie items when the network is connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource.getMovieCategory(category, page))
          .thenAnswer((_) async => movieList);

      // Call the repository method
      final result = await repository.getMovieCategory(category, page);

      // Verify the result
      expect(result.isRight, true);
      expect(result.isLeft, false);
      expect(result.right.value, movieList);
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource.getMovieCategory(category, page));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return a ServerError when an exception is thrown', () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource.getMovieCategory(category, page))
          .thenThrow(Exception());

      // Call the repository method
      final result = await repository.getMovieCategory(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);
      expect(result.left.error, equals(ServerError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource.getMovieCategory(category, page));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return an InternetError when the network is disconnected',
        () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Call the repository method
      final result = await repository.getMovieCategory(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);

      expect(result.left.error, equals(InternetError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockDataSource);
    });
  });
}
