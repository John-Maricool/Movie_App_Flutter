import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeDataSource {
  Future<List<MovieListItemModel>> getMovieCategory(String category, int page);
}

class HomeDataSourceImpl implements HomeDataSource {
  final http.Client client;

  HomeDataSourceImpl({required this.client});

  @override
  Future<List<MovieListItemModel>> getMovieCategory(
      String category, int page) async {
    final response = await client.get(
      Uri.parse("${BASE_URL}movie/$category?api_key=$API_KEY&page=$page"),
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
