import 'package:either_dart/either.dart';
import 'package:movie_app/core/failure/failure.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';
import 'package:movie_app/single_cast_detail/domain/repositories/single_cast_deetails_repo.dart';

class SingleCastDetailsUsecase {
  SingleCastDetailsRepo repo;

  SingleCastDetailsUsecase({required this.repo});

  getCastDetails(
      int id, Function(Either<Failure, Result<SingleCastModel>> b) res) async {
    await repo.getCastDetails(id).then((value) => res.call(value));
  }
}
