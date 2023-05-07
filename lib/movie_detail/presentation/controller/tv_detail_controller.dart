import 'package:get/get.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/usecases/tv_detail_usecase.dart';

class TvDetailController extends GetxController {
  TvDetailUsecaseImpl usecase;

  TvDetailController({required this.usecase});

  final RxList<Cast> _data1 = (List<Cast>.of([])).obs;
  final RxList<Video> _data2 = (List<Video>.of([])).obs;
  final Rx<TvDetail?> _detail = Rx(TvDetail.empty());

  // ignore: invalid_use_of_protected_member
  List<Cast> get data1 => _data1.value;
  // ignore: invalid_use_of_protected_member
  List<Video> get data2 => _data2.value;
  TvDetail? get detail => _detail.value;

  final _state1 = const State().obs;
  final _state2 = const State().obs;
  final _stateDetail = const State().obs;
  State get state1 => _state1.value;
  State get stateDetail => _stateDetail.value;
  State get state2 => _state2.value;

  setId(int id) {
    getCasts(id);
    getMovieDetail(id);
    getVideos(id);
  }

  getCasts(int id) {
    _state1.value = LoadingState();
    usecase.getMovieCasts(id, (result) {
      if (result.isLeft) {
        _state1.value = ErrorState(errorType: result.left.error);
      } else {
        _data1.value = result.right.value;
        _state1.value = FinishedState();
      }
    });
  }

  getVideos(int id) {
    _state2.value = LoadingState();
    usecase.getMovieVideos(id, (result) {
      if (result.isLeft) {
        _state2.value = ErrorState(errorType: result.left.error);
      } else {
        _data2.value = result.right.value;
        _state2.value = FinishedState();
      }
    });
  }

  getMovieDetail(int id) {
    _stateDetail.value = LoadingState();
    usecase.getMovieDetail(id, (result) {
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
    Get.delete<TvDetailController>();
    super.onClose();
  }
}
