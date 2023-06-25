import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';
import 'package:movie_app/movie_detail/presentation/controller/movie_detail_controller.dart';

class MovieDetailBinding implements Bindings {
  @override
  void dependencies() {
    HttpClient client = Get.find<HttpClient>();
    NetworkInfo info = Get.find<NetworkInfo>();
    _getMovieDetailBinding(client, info);
  }

  _getMovieDetailBinding(HttpClient client, NetworkInfo info) {
    Get.lazyPut<MovieDetailDatasource>(
        () => MovieDetailDatasourceImpl(client: Client()));
    Get.lazyPut<MovieDetailRepo>(() => MovieDetailRepoImpl(
        datasource: Get.find<MovieDetailDatasource>(), info: info));
    Get.lazyPut<MovieDetailUsecase>(
        () => MovieDetailUsecaseImpl(repo: Get.find<MovieDetailRepo>()));
    Get.lazyPut<MovieDetailController>(() => MovieDetailController(
          usecase: Get.find<MovieDetailUsecase>() as MovieDetailUsecaseImpl,
        ));
  }
}
