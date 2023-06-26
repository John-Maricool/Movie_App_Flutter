import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;

abstract class MovieDetailDatasource<T> {
  Future<T> getMovieDetail(int id, String type);
}

class MovieDetailDatasourceImpl implements MovieDetailDatasource<MovieDetail> {
  final http.Client client;

  MovieDetailDatasourceImpl({required this.client});
  @override
  Future<MovieDetail> getMovieDetail(int id, String type) async {
    final response = await client.get(
      Uri.parse("$BASE_URL$type/$id?api_key=$API_KEY"),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return MovieDetail.toMovieModel(result);
    } else {
      throw Exception();
    }
  }
}
