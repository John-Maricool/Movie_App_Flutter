import 'package:either_dart/either.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/movie_detail/data/datasource/movie_detail_datasource.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';

abstract class MovieDetailRepo {
  Future<Either<Failure, Result<MovieDetail>>> getMovieDetail(
      String type, int id);
}

class MovieDetailRepoImpl implements MovieDetailRepo {
  MovieDetailDatasource datasource;
  NetworkInfo info;
  MovieDetailRepoImpl({required this.datasource, required this.info});
  @override
  Future<Either<Failure, Result<MovieDetail>>> getMovieDetail(
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
}
