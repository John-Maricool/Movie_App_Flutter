import 'package:either_dart/either.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/datasource/casts_and_videos_datasource.dart';
import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';

abstract class TvDetailRepo {
  Future<Either<Failure, Result<TvDetail>>> getTvDetail(String type, int id);
  Future<Either<Failure, Result<List<Cast>>>> getTvCasts(String type, int id);
  Future<Either<Failure, Result<List<Video>>>> getTvVideos(String type, int id);
}

class TvDetailRepoImpl implements TvDetailRepo {
  MovieDetailDatasource<TvDetail> datasource;
  CastsAndVideosDatasource datasource2;
  NetworkInfo info;
  TvDetailRepoImpl(
      {required this.datasource,
      required this.datasource2,
      required this.info});

  @override
  Future<Either<Failure, Result<TvDetail>>> getTvDetail(
      String type, int id) async {
    if (await info.isConnected) {
      try {
        final result = await datasource.getMovieDetail(id, type);
        return Right(Result(value: result));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<List<Cast>>>> getTvCasts(
      String type, int id) async {
    if (await info.isConnected) {
      try {
        final result = await datasource2.getCast(id, type);
        return Right(Result(value: result));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }

  @override
  Future<Either<Failure, Result<List<Video>>>> getTvVideos(
      String type, int id) async {
    if (await info.isConnected) {
      try {
        final result = await datasource2.getVideos(id, type);
        return Right(Result(value: result));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
