import 'package:either_dart/either.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/home/data/datasources/home_data_source.dart';

abstract class HomeRepository {
  Future<Either<Failure, Result<List<MovieListItemModel>>>> getMovieCategory(
      String category, int page);
}

class HomeRepositoryImpl implements HomeRepository {
  HomeDataSource datasource;
  NetworkInfo info;
  HomeRepositoryImpl({required this.datasource, required this.info});

  @override
  Future<Either<Failure, Result<List<MovieListItemModel>>>> getMovieCategory(
      String category, int page) async {
    if (await info.isConnected) {
      try {
        final result = await datasource.getMovieCategory(category, page);
        return Right(Result(value: result));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
