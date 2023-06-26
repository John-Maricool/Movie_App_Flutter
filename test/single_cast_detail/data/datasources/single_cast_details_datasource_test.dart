import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/single_cast_detail/data/datasources/single_cast_details_datasource.dart';
import 'package:movie_app/single_cast_detail/data/models/single_cast_model.dart';

import '../../../home/data/datasources/home_data_source_test.mocks.dart';

void main() {
  group('SingleCastDetailsDatasource', () {
    late SingleCastDetailsDatasourceImpl dataSource;
    late MockNetworkClient mockNetworkClient;

    setUp(() {
      mockNetworkClient = MockNetworkClient();

      dataSource = SingleCastDetailsDatasourceImpl(mockNetworkClient);
    });

    test('getCastDetails should return SingleCastModel', () async {
      final name = "John";
      final personDetailsResponse = Response(
          '{"profile_path": "profile_path", "name": "name", "known_for_department": "known_for_department", "biography":"biography"}',
          200);
      final personPicsResponse = Response(
          '{"profiles": [{"file_path": "path"},{"file_path": "path"}]}', 200);
      final personCombinedCreditsResponse = Response(
          '{"cast": [{"id": 1, "title": "title", "poster_path": "poster_path"},{"id": 1, "title": "title", "poster_path": "poster_path"}]}',
          200);

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}person/1?api_key=$API_KEY"),
      )).thenAnswer((realInvocation) async => personDetailsResponse);

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}person/1/images?api_key=$API_KEY"),
      )).thenAnswer((realInvocation) async => personPicsResponse);

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}person/1/combined_credits?api_key=$API_KEY"),
      )).thenAnswer((realInvocation) async => personCombinedCreditsResponse);

      final result = await dataSource.getCastDetails(1);

      expect(result, isA<SingleCastModel>());
      expect(result.role, "known_for_department");
      expect(result.name, "name");
    });

    test('getCastDetails should throw exception', () async {
      final personDetailsResponse = Response(
          '{"profile_path": "profile_path", "name": "name", "known_for_department": "known_for_department", "biography":"biography"}',
          300);
      final personPicsResponse = Response(
          '{"profiles": [{"file_path": "path"},{"file_path": "path"}]}', 200);
      final personCombinedCreditsResponse = Response(
          '{"cast": [{"id": 1, "title": "title", "poster_path": "poster_path"},{"id": 1, "title": "title", "poster_path": "poster_path"}]}',
          200);

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}person/1?api_key=$API_KEY"),
      )).thenAnswer((realInvocation) async => personDetailsResponse);

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}person/1/images?api_key=$API_KEY"),
      )).thenAnswer((realInvocation) async => personPicsResponse);

      when(mockNetworkClient.get(
        Uri.parse("${BASE_URL}person/1/combined_credits?api_key=$API_KEY"),
      )).thenAnswer((realInvocation) async => personCombinedCreditsResponse);

      final result = dataSource.getCastDetails(1);

      expect(result, throwsException);
    });
  });
}
