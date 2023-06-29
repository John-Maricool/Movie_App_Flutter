import 'package:get/get.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/domain/usecases/home_category_usecase.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';

abstract class HomeController {
  getPopularMovies();
  getUpcomingMovies();
  getTopRatedMovies();
}

class HomeControllerImpl extends GetxController implements HomeController {
  HomeCategoryUsecase usecase;
  MovieDetailUsecase detailUsecase;

  HomeControllerImpl({required this.usecase, required this.detailUsecase});

  final RxList<MovieListItemModel> _data1 =
      (List<MovieListItemModel>.of([])).obs;
  final RxList<MovieListItemModel> _data2 =
      (List<MovieListItemModel>.of([])).obs;
  final RxList<MovieListItemModel> _data3 =
      (List<MovieListItemModel>.of([])).obs;
  final Rx<MovieDetail> _detail = MovieDetail.empty().obs;

  List<MovieListItemModel> get data1 => _data1.value;
  List<MovieListItemModel> get data2 => _data2.value;
  List<MovieListItemModel> get data3 => _data3.value;
  MovieDetail get detail => _detail.value;

  final _state1 = const State().obs;
  final _state2 = const State().obs;
  final _state3 = const State().obs;
  final _stateDetail = const State().obs;
  State get state1 => _state1.value;
  State get stateDetail => _stateDetail.value;
  State get state2 => _state2.value;
  State get state3 => _state3.value;

  @override
  getPopularMovies() {
    _state1.value = LoadingState();
    usecase.getMovieCategory(1, "popular", (result) {
      if (result.isLeft) {
        _state1.value = ErrorState(errorType: result.left.error);
      } else {
        _data1.value = result.right.value;
        if (_data1.isNotEmpty) {
          _getMovieDetail(_data1[0].id);
        }
        _state1.value = FinishedState();
      }
    });
  }

  @override
  getUpcomingMovies() {
    _state2.value = LoadingState();
    usecase.getMovieCategory(1, "upcoming", (result) {
      if (result.isLeft) {
        _state2.value = ErrorState(errorType: result.left.error);
      } else {
        _data2.value = result.right.value;
        _state2.value = FinishedState();
      }
    });
  }

  @override
  getTopRatedMovies() {
    _state3.value = LoadingState();
    usecase.getMovieCategory(1, "top_rated", (result) {
      if (result.isLeft) {
        _state3.value = ErrorState(errorType: result.left.error);
      } else {
        _data3.value = result.right.value;
        _state3.value = FinishedState();
      }
    });
  }

  _getMovieDetail(int id) {
    _stateDetail.value = LoadingState();
    detailUsecase.getMovieDetail(id, (result) {
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
    Get.delete<HomeControllerImpl>();
    super.onClose();
  }
}
