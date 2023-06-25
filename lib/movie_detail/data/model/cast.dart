class Cast {
  int id = 0;
  String name = "";
  String? profile_path = "";
  String? known_for_department = "";

  Cast(
      {required this.id,
      required this.name,
      required this.profile_path,
      required this.known_for_department});

  Cast.empty();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Cast && id == other.id;
  }

  factory Cast.toCast(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final profilePath = json['profile_path'] != null
        ? "https://image.tmdb.org/t/p/w185" + json['profile_path']
        : null;
    final known_for_department = json['known_for_department'];

    return Cast(
        id: id,
        name: name,
        profile_path: profilePath,
        known_for_department: known_for_department);
  }
}
