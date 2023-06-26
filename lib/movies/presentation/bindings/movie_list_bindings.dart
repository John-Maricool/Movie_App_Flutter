import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movie_app/movies/presentation/controllers/movie_list_controller.dart';
import '../../../core/network/network_info.dart';
import '../../data/datasources/movie_list_datasource.dart';
import '../../domain/repository/movie_list_repository.dart';
import '../../domain/usecase/movie_list_usecase.dart';

class MovieListBindings implements Bindings {
  @override
  void dependencies() {
    NetworkInfo info = Get.find<NetworkInfo>();
    _getMovieBinding(info);
  }

  _getMovieBinding(NetworkInfo info) {
    Get.lazyPut<MovieListDataSource>(
        () => MovieListDataSourceImpl(client: Client()));
    Get.lazyPut<MovieListRepository>(() => MovieListRepositoryImpl(
        datasource: Get.find<MovieListDataSource>(), info: info));
    Get.lazyPut<MovieListUsecase>(
        () => MovieListUsecase(repo: Get.find<MovieListRepository>()));
    Get.lazyPut<MovieListController>(
        () => MovieListController(usecase: Get.find<MovieListUsecase>()));
  }
}
