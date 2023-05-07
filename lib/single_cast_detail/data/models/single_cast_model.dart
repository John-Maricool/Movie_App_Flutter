import 'package:movie_app/core/data_model/movei_list_item_model.dart';

class SingleCastModel {
  String? image;
  String? name;
  String? role;
  String? desc;
  List<String>? images;
  List<MovieListItemModel>? movie;

  SingleCastModel(
      {this.image, this.name, this.role, this.desc, this.images, this.movie});
  SingleCastModel.empty();

  factory SingleCastModel.fromJson(Map<String, dynamic> json, List<String> pics,
      List<MovieListItemModel> movies) {
    return SingleCastModel(
        image: "https://image.tmdb.org/t/p/w780" + json['profile_path'],
        name: json['name'],
        role: json['known_for_department'],
        desc: json['biography'],
        images: pics,
        movie: movies);
  }
}
