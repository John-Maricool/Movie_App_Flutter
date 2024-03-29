// Mocks generated by Mockito 5.4.0 from annotations
// in movie_app/test/movie_detail/domain/usecases/tv_detail_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:either_dart/either.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_app/core/failure/failure.dart' as _i5;
import 'package:movie_app/core/result/result.dart' as _i6;
import 'package:movie_app/movie_detail/data/model/cast.dart' as _i8;
import 'package:movie_app/movie_detail/data/model/tv_detail.dart' as _i7;
import 'package:movie_app/movie_detail/data/model/video.dart' as _i9;

import 'tv_detail_usecase_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvDetailRepoTest].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailRepoTest extends _i1.Mock implements _i3.TvDetailRepoTest {
  MockTvDetailRepoTest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Result<_i7.TvDetail>>> getTvDetail(
    String? type,
    int? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvDetail,
          [
            type,
            id,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.Result<_i7.TvDetail>>>.value(
                _FakeEither_0<_i5.Failure, _i6.Result<_i7.TvDetail>>(
          this,
          Invocation.method(
            #getTvDetail,
            [
              type,
              id,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Result<_i7.TvDetail>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Result<List<_i8.Cast>>>> getTvCasts(
    String? type,
    int? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvCasts,
          [
            type,
            id,
          ],
        ),
        returnValue: _i4.Future<
                _i2.Either<_i5.Failure, _i6.Result<List<_i8.Cast>>>>.value(
            _FakeEither_0<_i5.Failure, _i6.Result<List<_i8.Cast>>>(
          this,
          Invocation.method(
            #getTvCasts,
            [
              type,
              id,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Result<List<_i8.Cast>>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Result<List<_i9.Video>>>> getTvVideos(
    String? type,
    int? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvVideos,
          [
            type,
            id,
          ],
        ),
        returnValue: _i4.Future<
                _i2.Either<_i5.Failure, _i6.Result<List<_i9.Video>>>>.value(
            _FakeEither_0<_i5.Failure, _i6.Result<List<_i9.Video>>>(
          this,
          Invocation.method(
            #getTvVideos,
            [
              type,
              id,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Result<List<_i9.Video>>>>);
}
