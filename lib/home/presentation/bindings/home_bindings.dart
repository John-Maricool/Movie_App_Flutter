import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movie_app/home/data/datasources/home_data_source.dart';
import 'package:movie_app/home/domain/repo/home_repository.dart';
import 'package:movie_app/home/domain/usecases/home_category_usecase.dart';
import 'package:movie_app/home/presentation/controller/home_controller.dart';
import 'package:movie_app/home/presentation/controller/movie_category_controller.dart';
import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';
import '../../../core/network/network_info.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    HttpClient client = Get.find<HttpClient>();
    NetworkInfo info = Get.find<NetworkInfo>();
    _getMovieBinding(client, info);
  }

  _getMovieBinding(HttpClient client, NetworkInfo info) {
    Get.lazyPut<HomeDataSource>(() => HomeDataSourceImpl(client: Client()));
    Get.lazyPut<HomeRepository>(() =>
        HomeRepositoryImpl(datasource: Get.find<HomeDataSource>(), info: info));
    Get.lazyPut<HomeCategoryUsecase>(
        () => HomeCategoryUsecase(repo: Get.find<HomeRepository>()));
    Get.lazyPut<MovieDetailDatasource>(() => MovieDetailDatasourceImpl());
    Get.lazyPut<MovieDetailRepo>(() => MovieDetailRepoImpl(
        datasource: Get.find<MovieDetailDatasource>(), info: info));
    Get.lazyPut<MovieDetailUsecase>(
        () => MovieDetailUsecaseImpl(repo: Get.find<MovieDetailRepo>()));
    Get.lazyPut<HomeController>(() => HomeController(
        usecase: Get.find<HomeCategoryUsecase>(),
        detailUsecase: Get.find<MovieDetailUsecase>()));
    Get.lazyPut<MovieCategoryController>(
      () => MovieCategoryController(usecase: Get.find<HomeCategoryUsecase>()),
    );
  }
}
