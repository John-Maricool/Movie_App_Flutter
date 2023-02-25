import 'package:either_dart/either.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/home/domain/repo/home_repository.dart';

class HomeCategoryUsecase {
  HomeRepository repo;

  HomeCategoryUsecase({required this.repo});

  getPopularMovies(int page,
      Function(Either<Failure, Result<List<MovieListItemModel>>> b) res) async {
    await repo
        .getMovieCategory("popular", page)
        .then((value) => res.call(value));
  }

  getUpcomingMovies(int page,
      Function(Either<Failure, Result<List<MovieListItemModel>>> b) res) async {
    await repo
        .getMovieCategory("upcoming", page)
        .then((value) => res.call(value));
  }

  getInTheatreMovies(int page,
      Function(Either<Failure, Result<List<MovieListItemModel>>> b) res) async {
    await repo
        .getMovieCategory("now_playing", page)
        .then((value) => res.call(value));
  }
}
