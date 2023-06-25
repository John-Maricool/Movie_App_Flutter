import 'package:either_dart/either.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/domain/repo/movie_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/repo/tv_detail_repo.dart';
import 'package:movie_app/movie_detail/domain/usecases/movie_detail_usease.dart';

class TvDetailUsecaseImpl {
  TvDetailRepo repo;

  TvDetailUsecaseImpl({required this.repo});

  getMovieDetail(int id, Function(Either<Failure, Result<TvDetail>> b) res) {
    repo.getTvDetail("tv", id).then((value) => res.call(value));
  }

  getMovieCasts(int id, Function(Either<Failure, Result<List<Cast>>> b) res) {
    repo.getTvCasts("tv", id).then((value) => res.call(value));
  }

  getMovieVideos(int id, Function(Either<Failure, Result<List<Video>>> b) res) {
    repo.getTvVideos("tv", id).then((value) => res.call(value));
  }
}
