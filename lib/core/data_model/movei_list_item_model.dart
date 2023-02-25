class MovieListItemModel {
  String? title;
  String? image;
  int id;
  MovieListItemModel(
      {required this.id, required this.title, required this.image});

  factory MovieListItemModel.toMovieModel(Map<String, dynamic> json) {
    return MovieListItemModel(
      id: json['id'],
      title: json['title'],
      image: "https://image.tmdb.org/t/p/w185" + json['poster_path'],
    );
  }

  factory MovieListItemModel.toTvModel(Map<String, dynamic> json) {
    return MovieListItemModel(
      id: json['id'],
      title: json['name'],
      image: "https://image.tmdb.org/t/p/w185" + json['poster_path'],
    );
  }
}
