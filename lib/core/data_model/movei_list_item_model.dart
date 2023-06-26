class MovieListItemModel {
  final String title;
  final String image;
  final int id;

  MovieListItemModel({
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieListItemModel && id == other.id;
  }

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
