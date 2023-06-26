import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/single_cast_detail/data/datasources/single_cast_details_datasource.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';
import 'package:movie_app/single_cast_detail/domain/repositories/single_cast_deetails_repo.dart';

import '../../../home/domain/repo/home_repository_test.mocks.dart';
import 'single_cast_deetails_repo_test.mocks.dart';

class SingleCastDetailsDatasourceTest extends Mock
    implements SingleCastDetailsDatasource {}

@GenerateMocks([SingleCastDetailsDatasourceTest])
void main() {
  final singleCast = SingleCastModel(
      image: "image",
      name: "name",
      role: "role",
      desc: "desc",
      images: [],
      movie: []);

  group('SingleCastDetailsRepo', () {
    late SingleCastDetailsRepo repo;
    late MockSingleCastDetailsDatasourceTest datasource;
    late MockNetworkInfoTest mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkInfoTest();
      datasource = MockSingleCastDetailsDatasourceTest();

      repo = SingleCastDetailsRepoImpl(
          datasource: datasource, info: mockNetworkClient);
    });

    test('should return movie Detail Class when the network is connected',
        () async {
      when(mockNetworkClient.isConnected).thenAnswer((_) async => true);
      when(datasource.getCastDetails(1)).thenAnswer((_) async => singleCast);

      // Call the repository method
      final result = await repo.getCastDetails(1);

      // Verify the result
      expect(result.isRight, true);
      expect(result.isLeft, false);
      expect(result.right.value, isA<SingleCastModel>());
      expect(result.right.value, singleCast);
      // Verify the mock invocations
      verify(repo.getCastDetails(1));
      verifyNoMoreInteractions(mockNetworkClient);
    });

    test('should return a ServerError when an exception is thrown', () async {
      // Set up mock behavior
      when(mockNetworkClient.isConnected).thenAnswer((_) async => true);
      when(datasource.getCastDetails(1)).thenThrow(Exception());

      // Call the repository method
      final result = await repo.getCastDetails(1);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);
      expect(result.left.error, equals(ServerError()));
      // Verify the mock invocations
      verify(repo.getCastDetails(1));
      verifyNoMoreInteractions(mockNetworkClient);
    });

    test('should return an InternetError when the network is disconnected',
        () async {
      // Set up mock behavior
      when(mockNetworkClient.isConnected).thenAnswer((_) async => false);

      // Call the repository method
      final result = await repo.getCastDetails(1);

      // Verify the result
      expect(result.isLeft, true);
      expect(result.isRight, false);

      expect(result.left.error, equals(InternetError()));
      // Verify the mock invocations
      //verifyZeroInteractions(mockNetworkClient);
    });
  });
}
