import 'package:get/get.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';
import 'package:movie_app/single_cast_detail/domain/usecases/single_cast_details_usecase.dart';

class SingleCastController extends GetxController {
  SingleCastDetailsUsecase usecase;

  SingleCastController({required this.usecase});

  final Rx<SingleCastModel> _detail = Rx(SingleCastModel.empty());

  SingleCastModel get detail => _detail.value;

  final _stateDetail = const State().obs;
  State get stateDetail => _stateDetail.value;

  setId(double id) {
    _getCastDetail(id);
  }

  _getCastDetail(double id) {
    _stateDetail.value = LoadingState();
    usecase.getCastDetails(id, (result) {
      if (result.isLeft) {
        _stateDetail.value = ErrorState(errorType: result.left.error);
      } else {
        _detail.value = result.right.value;
        _stateDetail.value = FinishedState();
      }
    });
  }

  @override
  void onClose() {
    Get.delete<SingleCastController>();
    super.onClose();
  }
}
