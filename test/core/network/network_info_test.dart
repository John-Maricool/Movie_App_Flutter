import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

class NetworkInfoTest extends Mock implements InternetConnectionChecker {}

@GenerateMocks([NetworkInfoTest])
void main() {
  group('Check network if it works', () {
    late NetworkInfo networkInfo;
    late MockNetworkInfoTest networkInfoTest;

    setUp(() {
      networkInfoTest = MockNetworkInfoTest();
      networkInfo = NetworkInfoImpl(networkInfoTest);
    });

    test('should return true when connected', () async {
      // Arrange
      when(networkInfoTest.hasConnection).thenAnswer((_) async => true);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, true);
      verify(networkInfoTest.hasConnection);
    });

    test('should return false when not connected', () async {
      // Arrange
      when(networkInfoTest.hasConnection).thenAnswer((_) async => false);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, false);
      verify(networkInfoTest.hasConnection);
    });
  });
}
