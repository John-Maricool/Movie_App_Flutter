class Genre {
  int? id;
  String? name;

  Genre({required this.id, required this.name});

  factory Genre.toGenreModel(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
  static List<Genre?> convertToGenreList(List<dynamic> json) {
    List<Genre> model = [];
    for (var element in json) {
      model.add(Genre.toGenreModel(element));
    }
    return model;
  }
}
