import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/genre.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';

import '../../../home/data/datasources/home_data_source_test.mocks.dart';

void main() {
  group("Movie Details", () {
    late MovieDetailDatasource dataSource;
    late MockNetworkClient mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkClient();
      dataSource = MovieDetailDatasourceImpl(client: mockNetworkClient);
    });

    test("should return movie detail when function is called", () async {
      const testResponse =
          '{"id": 1, "backdrop_path": "backdrop_path", "poster_path": "poster_path", "title": "title", "vote_count": 1, "vote_average": 1.3, "original_language": "original_language", "release_date": "release_date", "runtime": 0, "genres": [{"id": 1, "name": "name"}], "overview": "overview"}';

      final detail = MovieDetail(
          id: 1,
          poster_path: 'poster_path',
          backdrop_path: "backdrop_path",
          title: "title",
          vote_count: 1,
          vote_average: 1.3,
          original_language: "original_language",
          release_date: "release_date",
          runtime: 0,
          genres: [Genre(id: 1, name: "name")],
          overview: "overview");

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}popular/1?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 200));

      final result = await dataSource.getMovieDetail(1, 'popular');
      expect(result, isA<AbstractMovieDetail>());
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

    test("Check if the list of casts is returned", () async {
      const testResponse =
          '{"cast": [{"id": 1, "name": "first", "profile_path": "path", "known_for_department": "dep1"}, {"id": 1, "name": "first", "profile_path": "path", "known_for_department": "dep1"}]}';

      final detail = [
        Cast(
            id: 1,
            name: "first",
            profile_path: "path",
            known_for_department: "dep1"),
        Cast(
            id: 1,
            name: "first",
            profile_path: "path",
            known_for_department: "dep2")
      ];

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}popular/1/credits?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 200));

      final result = await dataSource.getCast(1, 'popular');
      expect(result, equals(detail));
    });

    test("Check if error is returned", () async {
      const testResponse = 'error';
      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}popular/1/credits?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 300));

      final result = dataSource.getCast(1, 'popular');
      expect(result, throwsException);
    });

    test("Check if the list of videos is returned", () async {
      const testResponse =
          '{"results": [{"id": "id1", "name": "first", "key": "path"}, {"id": "id2", "name": "second", "key": "path2"}]}';

      final detail = [
        Video(
          id: "id1",
          name: "first",
          key: "path",
        ),
        Video(
          id: "id2",
          name: "second",
          key: "path2",
        ),
      ];

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}popular/1/videos?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 200));

      final result = await dataSource.getVideos(1, 'popular');
      expect(result, equals(detail));
    });

    test("Check if error is returned", () async {
      const testResponse = 'error';
      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}popular/1/videos?api_key=$API_KEY"),
      )).thenAnswer((_) async => Response(testResponse, 300));

      final result = dataSource.getVideos(1, 'popular');
      expect(result, throwsException);
    });
  });
}
