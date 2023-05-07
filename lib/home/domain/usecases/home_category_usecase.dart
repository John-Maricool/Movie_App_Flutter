import 'package:either_dart/either.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/home/domain/repo/home_repository.dart';

class HomeCategoryUsecase {
  HomeRepository repo;

  HomeCategoryUsecase({required this.repo});
  getMovieCategory(int page, String type,
      Function(Either<Failure, Result<List<MovieListItemModel>>> b) res) async {
    await repo.getMovieCategory(type, page).then((value) => res.call(value));
  }
}
