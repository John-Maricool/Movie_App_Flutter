import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'dart:convert';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';

class TvDetailDatasourceImpl implements MovieDetailDatasource<TvDetail> {
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
        print("Stupid error by ${e.toString()}");
        return TvDetail.toTvModel(result);
      }
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
      try {
        return convertToCastList(result['cast']);
      } catch (e) {
        print("The id is $id");
        print("Stupid cast error by ${e.toString()}");
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

  List<Video> convertToVideoList(dynamic json) {
    final List<Video> model = [];
    if (json.isEmpty) {
      return model;
    } else {
      try {
        for (var element in json) {
          final video = Video.fromJson(element);
          model.add(video);
        }
        return model;
      } catch (e) {
        return model;
      }
    }
  }

  @override
  Future<List<Video>> getVideos(int id, String type) async {
    final response = await http.get(
      Uri.parse("$BASE_URL$type/$id/videos?api_key=$API_KEY"),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      try {
        return convertToVideoList(result);
      } catch (e) {
        print("The id is $id");
        print("The type is ${result.runtimeType}");
        print("Stupid videos error by ${e.toString()}");
        return convertToVideoList(result);
      }
    } else {
      throw Exception();
    }
  }
}
