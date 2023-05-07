import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail/data/model/video.dart';

abstract class MovieDetailDatasource<T> {
  Future<T> getMovieDetail(int id, String type);
  Future<List<Video>> getVideos(int id, String type);
  Future<List<Cast>> getCast(int id, String type);
}

class MovieDetailDatasourceImpl implements MovieDetailDatasource<MovieDetail> {
  @override
  Future<MovieDetail> getMovieDetail(int id, String type) async {
    final response = await http.get(
      Uri.parse("$BASE_URL$type/$id?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return MovieDetail.toMovieModel(result);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Cast>> getCast(int id, String type) async {
    final response = await http.get(
      Uri.parse("$BASE_URL$type/$id/credits?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final list = convertToCastList(result['cast']);
      return list;
    } else {
      throw Exception();
    }
  }

  List<Cast> convertToCastList(List<dynamic> json) {
    final List<Cast> model = [];
    try {
      for (var element in json) {
        final cast = Cast.toCast(element);
        model.add(cast);
      }
      return model;
    } catch (e) {
      return model;
    }
  }

  List<Video> convertToVideoList(List<dynamic> json) {
    final List<Video> model = [];
    try {
      for (var element in json) {
        final video = Video.fromJson(element);
        print(video.id);
        model.add(video);
      }
      return model;
    } catch (e) {
      return model;
    }
  }

  @override
  Future<List<Video>> getVideos(int id, String type) async {
    final response = await http.get(
      Uri.parse("$BASE_URL$type/$id/videos?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return convertToVideoList(result['results']);
    } else {
      throw Exception();
    }
  }
}
