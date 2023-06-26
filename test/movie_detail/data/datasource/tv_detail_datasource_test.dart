import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/movie_detail/data/datasource/tv_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/genre.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';

import '../../../home/data/datasources/home_data_source_test.mocks.dart';

void main() {
  group("Tv Details", () {
    late TvDetailDatasourceImpl dataSource;
    late MockNetworkClient mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkClient();
      dataSource = TvDetailDatasourceImpl(mockNetworkClient);
    });

    test("should return tv detail when function is called", () async {
      const testResponse =
          '{"id": 1, "backdrop_path": "backdrop_path", "poster_path": "poster_path", "original_name": "original_name", "vote_count": 1, "vote_average": 1.3, "number_of_episodes": 1, "number_of_seasons": 1, "first_air_date": "first_air_date", "genres": [{"id": 1, "name": "name"}], "overview": "overview"}';

      final detail = TvDetail(
          id: 1,
          poster_path: 'poster_path',
          backdrop_path: "backdrop_path",
          original_name: "original_name",
          vote_count: 1,
          vote_average: 1.3,
          number_of_episodes: 1,
          number_of_seasons: 1,
          first_air_date: "first_air_date",
          genres: [Genre(id: 1, name: "name")],
          overview: "overview");

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}tv/1?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 200));

      final result = await dataSource.getMovieDetail(1, 'tv');
      expect(result, isA<TvDetail>());
      expect(result, equals(detail));
    });

    test("should throw exception if function is called", () async {
      const testResponse = 'Error';

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}popular/1?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 400));

      final result = dataSource.getMovieDetail(1, 'popular');
      expect(result, throwsException);
    });
  });
}
