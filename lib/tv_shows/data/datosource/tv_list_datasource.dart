import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';

abstract class TvListDataSource {
  Future<List<MovieListItemModel>> getMovies(int page);
}

class TvListDataSourceImpl implements TvListDataSource {
  final http.Client client;

  TvListDataSourceImpl({required this.client});

  @override
  Future<List<MovieListItemModel>> getMovies(int page) async {
    final response = await http.get(
      Uri.parse("${BASE_URL}discover/tv?api_key=$API_KEY&page=$page"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return convertToTvList(result['results']);
    } else {
      throw Exception();
    }
  }

  List<MovieListItemModel> convertToTvList(List<dynamic> json) {
    List<MovieListItemModel> model = [];
    for (var element in json) {
      model.add(MovieListItemModel.toTvModel(element));
    }
    return model;
  }
}
