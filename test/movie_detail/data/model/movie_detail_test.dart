import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/genre.dart';

void main() {
  group('MovieDetail', () {
    late MovieDetail movieDetail;

    setUp(() {
      movieDetail = MovieDetail(
        id: 1,
        title: 'Test Movie',
        poster_path: 'poster_path',
        backdrop_path: 'backdrop_path',
        vote_count: 100,
        vote_average: 7.5,
        original_language: 'en',
        release_date: '2022-01-01',
        runtime: 120,
        genres: [
          Genre(id: 1, name: 'Action'),
          Genre(id: 2, name: 'Drama'),
        ],
        overview: 'Test overview',
      );
    });

    test('MovieDetail should have the correct properties', () {
      expect(movieDetail.id, 1);
      expect(movieDetail.title, 'Test Movie');
      expect(movieDetail.poster_path, 'poster_path');
      expect(movieDetail.backdrop_path, 'backdrop_path');
      expect(movieDetail.vote_count, 100);
      expect(movieDetail.vote_average, 7.5);
      expect(movieDetail.original_language, 'en');
      expect(movieDetail.release_date, '2022-01-01');
      expect(movieDetail.runtime, 120);
      expect(movieDetail.genres, hasLength(2));
      expect(movieDetail.overview, 'Test overview');
    });

    test(
        'MovieDetail.toMovieModel should create MovieDetail instance from JSON',
        () {
      final json = {
        'id': 1,
        'title': 'Test Movie',
        'poster_path': '/path/to/poster.jpg',
        'original_language': 'en',
        'vote_count': 100,
        'release_date': '2022-01-01',
        'backdrop_path': '/path/to/backdrop.jpg',
        'runtime': 120,
        'genres': [
          {'id': 1, 'name': 'Action'},
          {'id': 2, 'name': 'Drama'},
        ],
        'vote_average': 7.5,
        'genre_ids': [1, 2, 3],
        'overview': 'Test overview',
      };

      final movieModel = MovieDetail.toMovieModel(json);

      expect(movieModel.id, 1);
      expect(movieModel.title, 'Test Movie');
      expect(movieModel.poster_path,
          'https://image.tmdb.org/t/p/w185/path/to/poster.jpg');
      expect(movieModel.original_language, 'en');
      expect(movieModel.vote_count, 100);
      expect(movieModel.release_date, '2022-01-01');
      expect(movieModel.backdrop_path,
          'https://image.tmdb.org/t/p/w780/path/to/backdrop.jpg');
      expect(movieModel.runtime, 120);
      expect(movieModel.genres, hasLength(2));
      expect(movieModel.genres![0].id, 1);
      expect(movieModel.genres![0].name, 'Action');
      expect(movieModel.genres![1].id, 2);
      expect(movieModel.genres![1].name, 'Drama');
    });
  });
}
