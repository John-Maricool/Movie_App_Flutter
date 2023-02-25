import 'package:either_dart/either.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/tv_shows/domain/repo/tv_list_repo.dart';

class TvListUsecase {
  TvListRepository repo;

  TvListUsecase({required this.repo});

  getTvList(int page,
      Function(Either<Failure, Result<List<MovieListItemModel>>> b) res) async {
    await repo.getMovies(page).then((value) => res.call(value));
  }
}
