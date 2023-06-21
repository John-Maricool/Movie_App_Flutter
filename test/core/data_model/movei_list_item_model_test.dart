import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';

void main() {
  group("Testing Movie List Item Model Class", () {
    test("Tests if the movie response json really converts to Movie list item",
        () {
      final json = {
        'id': 1,
        'title': 'Movie 1',
        'poster_path': '/path/to/image.jpg',
      };

      final movieModel = MovieListItemModel.toMovieModel(json);

      expect(movieModel.id, json['id']);
      expect(movieModel.title, json['title']);
      expect(
        movieModel.image,
        'https://image.tmdb.org/t/p/w185${json['poster_path']}',
      );
    });
  });

  test('should create a MovieListItemModel from TV JSON', () {
    final json = {
      'id': 1,
      'name': 'Movie 1',
      'poster_path': '/path/to/image.jpg',
    };

    final movieModel = MovieListItemModel.toTvModel(json);

    expect(movieModel.id, json['id']);
    expect(movieModel.title, json['name']);
    expect(
      movieModel.image,
      'https://image.tmdb.org/t/p/w185${json['poster_path']}',
    );
  });

  test('should have non-null properties', () {
    final movieModel = MovieListItemModel(
      id: 1,
      title: 'Movie 1',
      image: 'https://example.com/image.jpg',
    );

    expect(movieModel.id, isNotNull);
    expect(movieModel.title, isNotNull);
    expect(movieModel.image, isNotNull);
  });
}
