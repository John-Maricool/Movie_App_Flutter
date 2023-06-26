import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail/data/model/video.dart';

abstract class CastsAndVideosDatasource {
  Future<List<Video>> getVideos(int id, String type);
  Future<List<Cast>> getCast(int id, String type);
}

class CastsAndVideosDatasourceImpl implements CastsAndVideosDatasource {
  final http.Client client;

  CastsAndVideosDatasourceImpl(this.client);

  @override
  Future<List<Cast>> getCast(int id, String type) async {
    final response = await client.get(
      Uri.parse("$BASE_URL$type/$id/credits?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      try {
        return convertToCastList(result['cast']);
      } catch (e) {
        return convertToCastList(result['cast']);
      }
    } else {
      throw Exception();
    }
  }

  List<Cast> convertToCastList(List<dynamic> json) {
    List<Cast> model = [];
    for (var element in json) {
      model.add(Cast.toCast(element));
    }
    return model;
  }

  List<Video> convertToVideoList(List<dynamic> json) {
    final List<Video> model = [];
    for (var element in json) {
      final video = Video.fromJson(element);
      model.add(video);
    }
    return model;
  }

  @override
  Future<List<Video>> getVideos(int id, String type) async {
    final response = await client.get(
      Uri.parse("$BASE_URL$type/$id/videos?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      try {
        return convertToVideoList(result['results']);
      } catch (e) {
        return convertToVideoList(result['results']);
      }
    } else {
      throw Exception();
    }
  }
}
