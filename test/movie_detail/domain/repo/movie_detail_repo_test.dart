import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/movie_detail/data/datasource/casts_and_videos_datasource.dart';
import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';

import '../../../home/domain/repo/home_repository_test.mocks.dart';
import 'movie_detail_repo_test.mocks.dart';

class MovieDetailDatasourceTest extends Mock
    implements MovieDetailDatasource<MovieDetail> {}

class CastsAndVideosDatasourceTest extends Mock
    implements CastsAndVideosDatasource {}

@GenerateMocks([MovieDetailDatasourceTest])
@GenerateMocks([CastsAndVideosDatasourceTest])
void main() {
  late MovieDetailRepo repository;
  late MockMovieDetailDatasourceTest mockDataSource;
  late MockCastsAndVideosDatasourceTest mockDataSource2;
  late MockNetworkInfoTest mockNetworkInfo;

  setUp(() {
    mockDataSource = MockMovieDetailDatasourceTest();
    mockDataSource2 = MockCastsAndVideosDatasourceTest();
    mockNetworkInfo = MockNetworkInfoTest();

    repository = MovieDetailRepoImpl(
        datasource: mockDataSource,
        datasource2: mockDataSource2,
        info: mockNetworkInfo);
  });

  group('get movie details', () {
    const category = 'popular';
    const page = 1;
    final movie = MovieDetail(
        id: 1,
        poster_path: "poster_path",
        backdrop_path: "backdrop_path",
        title: "title",
        vote_count: 2,
        vote_average: 2,
        original_language: "original_language",
        release_date: "release_date",
        runtime: 2,
        genres: [],
        overview: "overview");

    test('should return movie Detail Class when the network is connected',
        () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource.getMovieDetail(1, category))
          .thenAnswer((_) async => movie);

      // Call the repository method
      final result = await repository.getMovieDetail(category, 1);

      // Verify the result
      expect(result.isRight, true);
      expect(result.isLeft, false);
      expect(result.right.value, isA<MovieDetail>());
      expect(result.right.value, movie);
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource.getMovieDetail(1, category));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return a ServerError when an exception is thrown', () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource.getMovieDetail(page, category))
          .thenThrow(Exception());

      // Call the repository method
      final result = await repository.getMovieDetail(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);
      expect(result.left.error, equals(ServerError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource.getMovieDetail(page, category));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return an InternetError when the network is disconnected',
        () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Call the repository method
      final result = await repository.getMovieDetail(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);

      expect(result.left.error, equals(InternetError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockDataSource);
    });
  });

  group('get cast details', () {
    const category = 'popular';
    const page = 1;
    final casts = [
      Cast(
          id: 2,
          name: "name",
          profile_path: "profile_path",
          known_for_department: "known_for_department"),
      Cast(
          id: 3,
          name: "name",
          profile_path: "profile_path",
          known_for_department: "known_for_department")
    ];

    test('should return cast list when the network is connected', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource2.getCast(1, category)).thenAnswer((_) async => casts);

      // Call the repository method
      final result = await repository.getMovieCasts(category, 1);

      // Verify the result
      expect(result.isRight, true);
      expect(result.isLeft, false);
      expect(result.right.value, casts);
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource2.getCast(1, category));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return a ServerError when an exception is thrown', () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource2.getCast(page, category)).thenThrow(Exception());

      // Call the repository method
      final result = await repository.getMovieCasts(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);
      expect(result.left.error, equals(ServerError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource2.getCast(page, category));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return an InternetError when the network is disconnected',
        () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Call the repository method
      final result = await repository.getMovieCasts(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);

      expect(result.left.error, equals(InternetError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockDataSource);
    });
  });

  group('get video details', () {
    const category = 'popular';
    const page = 1;
    final videos = [
      Video(id: "2", name: "name", key: "key"),
      Video(id: "3", name: "name", key: "key"),
    ];

    test('should return videos list when the network is connected', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource2.getVideos(1, category))
          .thenAnswer((_) async => videos);

      // Call the repository method
      final result = await repository.getMovieVideos(category, 1);

      // Verify the result
      expect(result.isRight, true);
      expect(result.isLeft, false);
      expect(result.right.value, videos);
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource2.getVideos(1, category));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return a ServerError when an exception is thrown', () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockDataSource2.getVideos(page, category)).thenThrow(Exception());

      // Call the repository method
      final result = await repository.getMovieVideos(category, page);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);
      expect(result.left.error, equals(ServerError()));
      // Verify the mock invocations
      verify(mockNetworkInfo.isConnected);
      verify(mockDataSource2.getVideos(page, category));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return an InternetError when the network is disconnected',
        () async {
      // Set up mock behavior
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Call the repository method
      final result = await repository.getMovieVideos(category, page);

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
