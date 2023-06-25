class Video {
  String? id;
  String? name;
  String? key;

  Video({required this.id, required this.name, required this.key});

  Video.empty();

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(id: json['id'], name: json['name'], key: json['key']);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Video && id == other.id;
  }
}
