import 'package:get/get.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/movies/domain/usecase/movie_list_usecase.dart';
import 'package:movie_app/tv_shows/domain/usecase/tv_list_usecase.dart';

class TvListController extends GetxController {
  TvListUsecase usecase;

  TvListController({required this.usecase});

  final RxList<MovieListItemModel> _data =
      (List<MovieListItemModel>.of([])).obs;

  final RxBool isLast = false.obs;
  final RxInt currentPage = 1.obs;
  // ignore: invalid_use_of_protected_member
  List<MovieListItemModel> get data => _data.value;
  final _state = State().obs;
  State get state => _state.value;

  getMovies() {
    _state.value = LoadingState();
    usecase.getTvList(currentPage.value, (result) {
      if (result.isLeft) {
        _state.value = ErrorState(errorType: result.left.error);
      } else {
        currentPage.value += 1;
        _data.value = result.right.value;
        _state.value = FinishedState();
      }
    });
  }

  @override
  void onClose() {
    Get.delete<TvListController>();
    super.onClose();
  }

  fetchItems() {
    usecase.getTvList(currentPage.value, (result) {
      if (result.isLeft) {
        isLast.value = true;
      } else {
        _data.addAll(result.right.value);
        currentPage.value += 1;
      }
    });
  }
}
