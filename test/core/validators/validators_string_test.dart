import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/validators/validators_string.dart';

class DummyValidator with ValidatorMixin {}

void main() {
  group('ValidatorMixin tests', () {
    final validator = DummyValidator();

    test('getEmailErrors returns error for invalid email format', () {
      final email = 'example.com';
      final result = validator.getEmailErrors(email);
      expect(result, 'Invalid Email format missing @');
    });

    test('getEmailErrors returns error for short or empty email', () {
      final email = 'a@b.c';
      final result = validator.getEmailErrors(email);
      expect(result, 'This is not an email');
    });

    test('getEmailErrors returns empty string for valid email', () {
      final email = 'example@example.com';
      final result = validator.getEmailErrors(email);
      expect(result, '');
    });

    test('getPasswordErrors returns error for short password', () {
      final password = '12345';
      final result = validator.getPasswordErrors(password);
      expect(result, 'Password length is too short');
    });

    test('getPasswordErrors returns empty string for valid password', () {
      final password = 'strongpassword';
      final result = validator.getPasswordErrors(password);
      expect(result, '');
    });

    test('getInputFieldErrors returns error for short name', () {
      final name = 'Joe';
      final result = validator.getInputFieldErrors(name);
      expect(result, 'length is too short');
    });

    test('getInputFieldErrors returns error for empty name', () {
      final name = '';
      final result = validator.getInputFieldErrors(name);
      expect(result, 'length is too short');
    });

    test('getInputFieldErrors returns empty string for valid name', () {
      final name = 'John Doe';
      final result = validator.getInputFieldErrors(name);
      expect(result, '');
    });
  });
}
