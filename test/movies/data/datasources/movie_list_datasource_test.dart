import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/movies/data/datasources/movie_list_datasource.dart';

import '../../../home/data/datasources/home_data_source_test.mocks.dart';

void main() {
  group('HomeDataSourceImpl  Getting movie Categories', () {
    late MovieListDataSourceImpl dataSource;
    late MockNetworkClient mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkClient();
      dataSource = MovieListDataSourceImpl(client: mockNetworkClient);
    });

    test('should return a list of movie items when API call is successful',
        () async {
      final mockResponse = Response(
          '{"results": [{"id": 1, "title": "Movie 1", "poster_path": ""}, {"id": 2, "title": "Movie 2", "poster_path": "path"}]}',
          200);
      when(mockNetworkClient.get(
              Uri.parse("${BASE_URL}discover/movie?api_key=$API_KEY&page=1")))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getMovies(1);

      expect(result, isA<List<MovieListItemModel>>());
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].title, 'Movie 1');
      expect(result[1].id, 2);
      expect(result[1].title, 'Movie 2');
    });

    test('should throw an exception when API call fails', () async {
      final mockResponse = Response('', 400);
      when(mockNetworkClient.get(
              Uri.parse("${BASE_URL}discover/movie?api_key=$API_KEY&page=1")))
          .thenAnswer((_) async => mockResponse);

      expect(dataSource.getMovies(1), throwsException);
    });
  });
}
