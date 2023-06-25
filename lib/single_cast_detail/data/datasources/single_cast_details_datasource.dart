import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';

import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail/data/model/video.dart';

abstract class SingleCastDetailsDatasource {
  Future<SingleCastModel> getCastDetails(int id);
}

class SingleCastDetailsDatasourceImpl implements SingleCastDetailsDatasource {
  @override
  Future<SingleCastModel> getCastDetails(int id) async {
    print("The id is $id");
    final personDetails = await http.get(
      Uri.parse("${BASE_URL}person/$id?api_key=$API_KEY"),
    );
    final personPics = await http.get(
      Uri.parse("${BASE_URL}person/$id/images?api_key=$API_KEY"),
    );
    final personCombinedCredits = await http.get(
      Uri.parse("${BASE_URL}person/$id/combined_credits?api_key=$API_KEY"),
    );

    if (personDetails.statusCode == 200 &&
        personPics.statusCode == 200 &&
        personCombinedCredits.statusCode == 200) {
      final resultDetails = json.decode(personDetails.body);
      final resultPics = json.decode(personPics.body);
      final resultCombinedCredits = json.decode(personCombinedCredits.body);
      try {
        return SingleCastModel.fromJson(
            resultDetails,
            getImages(resultPics['profiles']),
            getCredits(resultCombinedCredits['cast']));
      } catch (e) {
        return SingleCastModel.fromJson(
            resultDetails,
            getImages(resultPics['profiles']),
            getCredits(resultCombinedCredits['cast']));
      }
    } else {
      throw Exception();
    }
  }

  List<String> getImages(List<dynamic> img) {
    final List<String> imges = [];
    try {
      for (var image in img) {
        var single = "https://image.tmdb.org/t/p/w780" + image["file_path"];
        imges.add(single);
        return imges;
      }
    } catch (e) {
      return imges;
    }
    return imges;
  }

  List<MovieListItemModel> getCredits(List<dynamic> data) {
    final List<MovieListItemModel> model = [];
    try {
      for (var d in data) {
        var single = MovieListItemModel.toMovieModel(d);
        print("A single is ${single.image}");
        model.add(single);
        return model;
      }
    } catch (e) {
      return model;
    }
    return model;
  }
}
