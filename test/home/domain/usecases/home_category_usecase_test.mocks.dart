// Mocks generated by Mockito 5.4.0 from annotations
// in movie_app/test/home/domain/usecases/home_category_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:either_dart/either.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_app/core/data_model/movei_list_item_model.dart' as _i7;
import 'package:movie_app/core/failure/failure.dart' as _i5;
import 'package:movie_app/core/result/result.dart' as _i6;

import 'home_category_usecase_test.dart' as _i3;

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

/// A class which mocks [HomeRepositoryTest].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeRepositoryTest extends _i1.Mock
    implements _i3.HomeRepositoryTest {
  MockHomeRepositoryTest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Result<List<_i7.MovieListItemModel>>>>
      getMovieCategory(
    String? category,
    int? page,
  ) =>
          (super.noSuchMethod(
            Invocation.method(
              #getMovieCategory,
              [
                category,
                page,
              ],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure,
                        _i6.Result<List<_i7.MovieListItemModel>>>>.value(
                _FakeEither_0<_i5.Failure,
                    _i6.Result<List<_i7.MovieListItemModel>>>(
              this,
              Invocation.method(
                #getMovieCategory,
                [
                  category,
                  page,
                ],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.Failure,
                  _i6.Result<List<_i7.MovieListItemModel>>>>);
}
