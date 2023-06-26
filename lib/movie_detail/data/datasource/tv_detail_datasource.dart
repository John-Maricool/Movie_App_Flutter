import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';

class TvDetailDatasourceImpl implements MovieDetailDatasource<TvDetail> {
  final http.Client client;

  TvDetailDatasourceImpl(this.client);
  @override
  Future<TvDetail> getMovieDetail(int id, String type) async {
    final response = await http.get(
      Uri.parse("$BASE_URL$type/$id?api_key=$API_KEY"),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      try {
        return TvDetail.toTvModel(result);
      } catch (e) {
        return TvDetail.toTvModel(result);
      }
    } else {
      throw Exception();
    }
  }
}
