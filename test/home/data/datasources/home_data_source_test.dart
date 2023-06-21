import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/home/data/datasources/home_data_source.dart';

import 'home_data_source_test.mocks.dart';

class NetworkClient extends Mock implements Client {}

@GenerateMocks([NetworkClient])
void main() {
  group('HomeDataSourceImpl  Getting movie Categories', () {
    late HomeDataSourceImpl dataSource;
    late MockNetworkClient mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkClient();
      dataSource = HomeDataSourceImpl(client: mockNetworkClient);
    });

    test('should return a list of movie items when API call is successful',
        () async {
      final mockResponse = Response(
          '{"results": [{"id": 1, "title": "Movie 1", "poster_path": "path"}, {"id": 2, "title": "Movie 2", "poster_path": "path"}]}',
          200);
      when(mockNetworkClient.get(
              Uri.parse("${BASE_URL}movie/popular?api_key=$API_KEY&page=1")))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getMovieCategory('popular', 1);

      expect(result, isA<List<MovieListItemModel>>());
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].title, 'Movie 1');
      expect(result[1].id, 2);
      expect(result[1].title, 'Movie 2');
    });

    test('should throw an exception when API call fails', () async {
      final mockResponse = http.Response('', 400);
      when(mockNetworkClient.get(
              Uri.parse("${BASE_URL}movie/popular?api_key=$API_KEY&page=1")))
          .thenAnswer((_) async => mockResponse);

      expect(dataSource.getMovieCategory('popular', 1), throwsException);
    });
  });
}
