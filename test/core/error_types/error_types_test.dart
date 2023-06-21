import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/error_types/error_types.dart';

void main() {
  group('ErrorType tests', () {
    group('InternetError tests', () {
      test('InternetError props should contain errMessage', () {
        final error = InternetError();
        expect(error.props, [error.errMessage]);
      });

      test('InternetError errMessage should be "No Internet"', () {
        final error = InternetError();
        expect(error.errMessage, 'No Internet');
      });

      test('InternetError stringify should be true', () {
        final error = InternetError();
        expect(error.stringify, isTrue);
      });
    });

    group('EmptyListError tests', () {
      test('EmptyListError props should contain errMessage', () {
        final error = EmptyListError();
        expect(error.props, [error.errMessage]);
      });

      test('EmptyListError stringify should be true', () {
        final error = EmptyListError();
        expect(error.stringify, isTrue);
      });
    });

    group('ServerError tests', () {
      test('ServerError props should contain self', () {
        final error = ServerError();
        expect(error.props, [error]);
      });

      test('ServerError stringify should be true', () {
        final error = ServerError();
        expect(error.stringify, isTrue);
      });
    });

    group('DefaultError tests', () {
      test('DefaultError props should contain self', () {
        final error = DefaultError();
        expect(error.props, [error]);
      });

      test('DefaultError stringify should be true', () {
        final error = DefaultError();
        expect(error.stringify, isTrue);
      });
    });
  });
}
