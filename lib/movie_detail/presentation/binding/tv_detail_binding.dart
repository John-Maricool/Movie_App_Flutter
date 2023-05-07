import 'dart:io';

import 'package:get/get.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/movie_detail/data/datasource/tv_detail_datasource.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/repo/tv_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/usecases/tv_detail_usecase.dart';
import 'package:movie_app/movie_detail/presentation/controller/movie_detail_controller.dart';
import 'package:movie_app/movie_detail/presentation/controller/tv_detail_controller.dart';

class TvDetailBinding implements Bindings {
  @override
  void dependencies() {
    HttpClient client = Get.find<HttpClient>();
    NetworkInfo info = Get.find<NetworkInfo>();
    _getMovieDetailBinding(client, info);
  }

  _getMovieDetailBinding(HttpClient client, NetworkInfo info) {
    Get.lazyPut<TvDetailDatasourceImpl>(() => TvDetailDatasourceImpl());
    Get.lazyPut<TvDetailRepo>(() => TvDetailRepoImpl(
        datasource: Get.find<TvDetailDatasourceImpl>(), info: info));
    Get.lazyPut<TvDetailUsecaseImpl>(
        () => TvDetailUsecaseImpl(repo: Get.find<TvDetailRepo>()));
    Get.lazyPut<TvDetailController>(() => TvDetailController(
          usecase: Get.find<TvDetailUsecaseImpl>(),
        ));
  }
}
