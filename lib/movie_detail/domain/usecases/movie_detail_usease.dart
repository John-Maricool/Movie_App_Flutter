import 'package:either_dart/either.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';

class MovieDetailUsecase {
  MovieDetailRepo repo;

  MovieDetailUsecase({required this.repo});

  getMovieDetail(
      int id, Function(Either<Failure, Result<MovieDetail>> b) res) async {
    await repo.getMovieDetail("movie", id).then((value) => res.call(value));
  }
}
