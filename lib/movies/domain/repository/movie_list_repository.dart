import 'package:either_dart/either.dart';

import '../../../core/error_types/error_types.dart';
import '../../../core/failure/failure.dart';
import '../../../core/network/network_info.dart';
import '../../../core/result/result.dart';
import '../../data/datasources/movie_list_datasource.dart';
import '../../../core/data_model/movei_list_item_model.dart';

abstract class MovieListRepository {
  Future<Either<Failure, Result<List<MovieListItemModel>>>> getMovies(int page);
}

class MovieListRepositoryImpl implements MovieListRepository {
  MovieListDataSource datasource;
  NetworkInfo info;
  MovieListRepositoryImpl({required this.datasource, required this.info});

  @override
  Future<Either<Failure, Result<List<MovieListItemModel>>>> getMovies(
      int page) async {
    if (await info.isConnected) {
      try {
        final result = await datasource.getMovies(page);
        return Right(Result(value: result));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
