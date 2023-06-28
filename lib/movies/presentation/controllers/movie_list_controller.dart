import 'package:get/get.dart';
import 'package:movie_app/movies/domain/usecase/movie_list_usecase.dart';
import '../../../core/state/state.dart';
import '../../../core/data_model/movei_list_item_model.dart';

class MovieListController extends GetxController {
  MovieListUsecase usecase;

  MovieListController({required this.usecase});

  final RxList<MovieListItemModel> _data =
      (List<MovieListItemModel>.of([])).obs;

  final RxBool isLast = false.obs;
  final RxInt currentPage = 1.obs;
  List<MovieListItemModel> get data => _data.value;
  final _state = const State().obs;
  State get state => _state.value;

  getMovies() {
    _state.value = LoadingState();
    usecase.getMovies(currentPage.value, (result) {
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
    Get.delete<MovieListController>();
    super.onClose();
  }

  fetchItems() {
    usecase.getMovies(currentPage.value, (result) {
      if (result.isLeft) {
        isLast.value = true;
      } else {
        _data.addAll(result.right.value);
        currentPage.value += 1;
      }
    });
  }
}
