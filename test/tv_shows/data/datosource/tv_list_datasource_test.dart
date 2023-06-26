import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/tv_shows/data/datosource/tv_list_datasource.dart';

import '../../../home/data/datasources/home_data_source_test.mocks.dart';

void main() {
  group("Testing tv list ", () {
    late TvListDataSource dataSource;
    late MockNetworkClient mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkClient();
      dataSource = TvListDataSourceImpl(client: mockNetworkClient);
    });

    test("Testing if a list is returned", () async {
      final mockResponse = Response(
          '{"results": [{"id": 1, "name": "Movie 1", "poster_path": "path"}, {"id": 2, "name": "Movie 2", "poster_path": "path"}]}',
          200);
      final mockRes = [
        MovieListItemModel(
            id: 1,
            title: "Movie 1",
            image: "https://image.tmdb.org/t/p/w185path"),
        MovieListItemModel(
            id: 2,
            title: "Movie 2",
            image: "https://image.tmdb.org/t/p/w185path")
      ];
      when(mockNetworkClient
              .get(Uri.parse("${BASE_URL}discover/tv?api_key=$API_KEY&page=1")))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getMovies(1);

      expect(result, isA<List<MovieListItemModel>>());
      expect(result[0].id, 1);
      expect(result[0].title, 'Movie 1');
      expect(result[1].id, 2);
      expect(result[1].title, 'Movie 2');
    });

    test("Testing if it throws exception", () async {
      final mockResponse = Response('Error', 400);

      when(mockNetworkClient
              .get(Uri.parse("${BASE_URL}discover/tv?api_key=$API_KEY&page=1")))
          .thenAnswer((_) async => mockResponse);

      final result = dataSource.getMovies(1);

      expect(result, throwsException);
    });
  });
}
