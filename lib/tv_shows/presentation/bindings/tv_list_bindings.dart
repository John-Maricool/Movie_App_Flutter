import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movie_app/movies/data/datasources/movie_list_datasource.dart';
import 'package:movie_app/movies/domain/repository/movie_list_repository.dart';
import 'package:movie_app/movies/domain/usecase/movie_list_usecase.dart';
import 'package:movie_app/movies/presentation/controllers/movie_list_controller.dart';
import 'package:movie_app/tv_shows/data/datosource/tv_list_datasource.dart';
import 'package:movie_app/tv_shows/domain/repo/tv_list_repo.dart';
import 'package:movie_app/tv_shows/domain/usecase/tv_list_usecase.dart';
import 'package:movie_app/tv_shows/presentation/controller/tv_list_controller.dart';
import '../../../core/network/network_info.dart';

class TvListBindings implements Bindings {
  @override
  void dependencies() {
    NetworkInfo info = Get.find<NetworkInfo>();
    _getMovieBinding(info);
  }

  _getMovieBinding(NetworkInfo info) {
    Get.lazyPut<TvListDataSource>(() => TvListDataSourceImpl(client: Client()));
    Get.lazyPut<TvListRepository>(() => TvListRepositoryImpl(
        datasource: Get.find<TvListDataSource>(), info: info));
    Get.lazyPut<TvListUsecase>(
        () => TvListUsecase(repo: Get.find<TvListRepository>()));
    Get.lazyPut<TvListController>(
        () => TvListController(usecase: Get.find<TvListUsecase>()));
  }
}
