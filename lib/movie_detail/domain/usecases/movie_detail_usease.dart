import 'package:either_dart/either.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';

abstract class MovieDetailUsecase {
  getMovieDetail(int id, Function(Either<Failure, Result<MovieDetail>> b) res);

  getMovieCasts(int id, Function(Either<Failure, Result<List<Cast>>> b) res);

  getMovieVideos(int id, Function(Either<Failure, Result<List<Video>>> b) res);
}

class MovieDetailUsecaseImpl implements MovieDetailUsecase {
  MovieDetailRepo repo;

  MovieDetailUsecaseImpl({required this.repo});

  @override
  getMovieDetail(
      int id, Function(Either<Failure, Result<MovieDetail>> b) res) async {
    await repo.getMovieDetail("movie", id).then(
        (value) => res.call(value as Either<Failure, Result<MovieDetail>>));
  }

  @override
  getMovieCasts(int id, Function(Either<Failure, Result<List<Cast>>> b) res) {
    repo.getMovieCasts("movie", id).then((value) => res.call(value));
  }

  @override
  getMovieVideos(
      int id, Function(Either<Failure, Result<List<Video>>> b) res) async {
    await repo.getMovieVideos("movie", id).then((value) => res.call(value));
  }
}
