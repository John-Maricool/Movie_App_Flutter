import 'package:get/get.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/domain/usecases/home_category_usecase.dart';

class MovieCategoryController extends GetxController {
  HomeCategoryUsecase usecase;

  MovieCategoryController({required this.usecase});

  final RxList<MovieListItemModel> _data1 =
      (List<MovieListItemModel>.of([])).obs;

  final RxBool isLast = false.obs;
  final RxInt currentPage = 1.obs;
  // ignore: invalid_use_of_protected_member
  List<MovieListItemModel> get data1 => _data1.value;

  final _state1 = const State().obs;
  State get state1 => _state1.value;

  getMovieCategory(String category) {
    _state1.value = LoadingState();
    usecase.getMovieCategory(currentPage.value, category, (result) {
      if (result.isLeft) {
        _state1.value = ErrorState(errorType: result.left.error);
      } else {
        currentPage.value += 1;
        _data1.value = result.right.value;
        _state1.value = FinishedState();
      }
    });
  }

  @override
  void onClose() {
    Get.delete<MovieCategoryController>();
    super.onClose();
  }

  void fetchItems(String category) {
    usecase.getMovieCategory(currentPage.value, category, (result) {
      if (result.isLeft) {
        isLast.value = true;
      } else {
        _data1.addAll(result.right.value);
        currentPage.value += 1;
      }
    });
  }
}
