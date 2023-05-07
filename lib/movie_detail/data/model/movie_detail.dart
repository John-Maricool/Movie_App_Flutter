import 'package:movie_app/movie_detail/data/model/genre.dart';

abstract class AbstractMovieDetail {}

class MovieDetailMiniImpl implements AbstractMovieDetail {
  MovieDetailMiniImpl.empty();
}

class MovieDetail implements AbstractMovieDetail {
  int? id;
  String? poster_path;
  String? backdrop_path;
  String? title;
  int? vote_count;
  double? vote_average;
  List<int>? genre_ids;
  String? original_language;
  String? release_date;
  int? runtime;
  String? overview;
  List<Genre?> genres = List.empty();

  MovieDetail(
      {required this.id,
      required this.poster_path,
      required this.backdrop_path,
      required this.title,
      required this.vote_count,
      required this.genre_ids,
      required this.vote_average,
      required this.original_language,
      required this.release_date,
      required this.runtime,
      required this.genres,
      required this.overview});

  MovieDetail.empty();

  factory MovieDetail.toMovieModel(Map<String, dynamic> json) {
    return MovieDetail(
        id: json['id'],
        title: json['title'],
        poster_path: "https://image.tmdb.org/t/p/w185" + json['poster_path'],
        original_language: json['original_language'],
        vote_count: json['vote_count'],
        release_date: json['release_date'],
        backdrop_path:
            "https://image.tmdb.org/t/p/w780" + json['backdrop_path'],
        runtime: json['runtime'],
        genres: Genre.convertToGenreList(json['genres']),
        vote_average: json['vote_average'],
        genre_ids: json['genre_ids'],
        overview: json['overview']);
  }
}
