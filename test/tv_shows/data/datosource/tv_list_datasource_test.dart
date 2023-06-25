import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
      const mockResponse =
          '{"results": [{"id": 1, "name": "Movie 1", "poster_path": "path"}, {"id": 2, "name": "Movie 2", "poster_path": "path"}]}';

      //   when(mockNetworkClient
      //         .get(Uri.parse("${BASE_URL}discover/tv?api_key=$API_KEY&page=1")))
      //   .thenAnswer((_) async => Response(mockResponse, 200));

      //    final result = await dataSource.getMovies(1);

//      expect(result, isA<List<MovieListItemModel>>());
      //    expect(result.length, 2);
      //  expect(result[0].id, 1);
      //   expect(result[0].title, 'Movie 1');
      // expect(result[1].id, 2);
      //  expect(result[1].title, 'Movie 2');
    });
  });
}
