class Cast {
  double id = 0;
  String name = "";
  String profile_path = "";
  String known_for_department = "";

  Cast(
      {required this.id,
      required this.name,
      required this.profile_path,
      required this.known_for_department});

  Cast.empty();

  factory Cast.toCast(Map<String, dynamic> json) {
    final id = json['id'].toDouble();
    final name = json['name'];
    final profilePath =
        "https://image.tmdb.org/t/p/w185" + json['profile_path'];
    final known_for_department = json['known_for_department'];

    return Cast(
        id: id,
        name: name,
        profile_path: profilePath,
        known_for_department: known_for_department);
  }
}
