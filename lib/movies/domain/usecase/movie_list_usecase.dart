import 'package:either_dart/either.dart';

import '../../../core/failure/failure.dart';
import '../../../core/result/result.dart';
import '../../../core/data_model/movei_list_item_model.dart';
import '../repository/movie_list_repository.dart';

class MovieListUsecase {
  MovieListRepository repo;

  MovieListUsecase({required this.repo});

  getMovies(int page,
      Function(Either<Failure, Result<List<MovieListItemModel>>> b) res) async {
    await repo.getMovies(page).then((value) => res.call(value));
  }
}
