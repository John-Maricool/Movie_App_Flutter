import 'package:get/get.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/single_cast_detail/data/datasources/single_cast_details_datasource.dart';
import 'package:movie_app/single_cast_detail/domain/repositories/single_cast_deetails_repo.dart';
import 'package:movie_app/single_cast_detail/domain/usecases/single_cast_details_usecase.dart';
import 'package:movie_app/single_cast_detail/presentation/controller/single_cast_controller.dart';

class SingleCastDetailsBindings implements Bindings {
  @override
  void dependencies() {
    NetworkInfo info = Get.find<NetworkInfo>();
    Get.lazyPut<SingleCastDetailsDatasource>(
        () => SingleCastDetailsDatasourceImpl());
    Get.lazyPut<SingleCastDetailsRepo>(() => SingleCastDetailsRepoImpl(
        datasource: Get.find<SingleCastDetailsDatasource>(), info: info));
    Get.lazyPut<SingleCastDetailsUsecase>(() =>
        SingleCastDetailsUsecase(repo: Get.find<SingleCastDetailsRepo>()));
    Get.lazyPut<SingleCastController>(() => SingleCastController(
          usecase: Get.find<SingleCastDetailsUsecase>(),
        ));
  }
}
