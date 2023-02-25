import 'dart:io';

import 'package:movie_app/core/network/network_info.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_app/home/data/datasources/home_data_source.dart';
import 'package:movie_app/home/domain/usecases/home_category_usecase.dart';
import 'package:movie_app/home/presentation/controller/home_controller.dart';

import 'home/domain/repo/home_repository.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));
    final client = Get.put(HttpClient());
    // _getMovieBinding(client, Get.find<NetworkInfo>());
  }
}
