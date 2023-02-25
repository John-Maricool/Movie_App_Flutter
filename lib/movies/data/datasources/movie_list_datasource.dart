import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/string_constants.dart';
import 'dart:convert';

import 'package:movie_app/core/data_model/movei_list_item_model.dart';

abstract class MovieListDataSource {
  Future<List<MovieListItemModel>> getMovies(int page);
}

class MovieListDataSourceImpl implements MovieListDataSource {
  final HttpClient client;

  MovieListDataSourceImpl({required this.client});

  @override
  Future<List<MovieListItemModel>> getMovies(int page) async {
    final response = await http.get(
      Uri.parse("${BASE_URL}discover/movie?api_key=$API_KEY&page=$page"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return convertToMovieList(result['results']);
    } else {
      throw Exception();
    }
  }

  List<MovieListItemModel> convertToMovieList(List<dynamic> json) {
    List<MovieListItemModel> model = [];
    for (var element in json) {
      model.add(MovieListItemModel.toMovieModel(element));
    }
    return model;
  }
}
