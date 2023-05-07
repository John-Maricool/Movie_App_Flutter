import 'package:movie_app/movie_detail/data/model/genre.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';

class TvDetail implements AbstractMovieDetail {
  int? id;
  String? poster_path;
  String? backdrop_path;
  String? original_name;
  int? vote_count;
  double? vote_average;
  int? number_of_episodes;
  int? number_of_seasons;
  String? first_air_date;
  String? overview;
  List<Genre?>? genres = List.empty();

  TvDetail(
      {required this.id,
      required this.poster_path,
      required this.backdrop_path,
      required this.original_name,
      required this.vote_count,
      required this.number_of_episodes,
      required this.vote_average,
      required this.number_of_seasons,
      required this.first_air_date,
      required this.genres,
      required this.overview});

  TvDetail.empty();

  factory TvDetail.toTvModel(Map<String, dynamic> json) {
    return TvDetail(
        id: json['id'],
        original_name: json['original_name'],
        poster_path: "https://image.tmdb.org/t/p/w185" + json['poster_path'],
        number_of_episodes: json['number_of_episodes'],
        vote_count: json['vote_count'],
        number_of_seasons: json['number_of_seasons'],
        backdrop_path:
            "https://image.tmdb.org/t/p/w780" + json['backdrop_path'],
        first_air_date: json['first_air_date'],
        genres: Genre.convertToGenreList(json['genres']),
        vote_average: json['vote_average'],
        overview: json['overview']);
  }
}
