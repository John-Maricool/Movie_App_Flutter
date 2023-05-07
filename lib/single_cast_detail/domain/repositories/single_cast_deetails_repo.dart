import 'package:either_dart/either.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/single_cast_detail/data/datasources/single_cast_details_datasource.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';

abstract class SingleCastDetailsRepo {
  Future<Either<Failure, Result<SingleCastModel>>> getCastDetails(double id);
}

class SingleCastDetailsRepoImpl implements SingleCastDetailsRepo {
  SingleCastDetailsDatasource datasource;
  NetworkInfo info;
  SingleCastDetailsRepoImpl({required this.datasource, required this.info});

  @override
  Future<Either<Failure, Result<SingleCastModel>>> getCastDetails(
      double id) async {
    if (await info.isConnected) {
      try {
        final result = await datasource.getCastDetails(id);
        return Right(Result(value: result));
      } on Exception {
        return Left(Failure(error: ServerError()));
      }
    } else {
      return Left(Failure(error: InternetError()));
    }
  }
}
