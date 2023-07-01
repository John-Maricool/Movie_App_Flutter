import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie_app/core/constants/route_constants.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/movie_detail/presentation/screens/custom_widgets.dart';
import 'package:movie_app/single_cast_detail/domain/usecases/single_cast_details_usecase.dart';
import 'package:movie_app/single_cast_detail/presentation/controller/single_cast_controller.dart';
import 'package:movie_app/single_cast_detail/presentation/screens/single_cast_screen.dart';

@GenerateMocks([])
void main() {
  final List<Cast> testCasts = [
    Cast(
        name: 'Actor 1',
        profile_path: 'path1',
        id: 1,
        known_for_department: "known"),
    Cast(
        name: 'Actor 1',
        profile_path: 'path1',
        id: 2,
        known_for_department: "known"),
    Cast(
        name: 'Actor 1',
        profile_path: 'path1',
        id: 3,
        known_for_department: "known"),
  ];

  final List<Video> testVideos = [
    Video(id: "id", name: "name", key: "key"),
    Video(id: "id", name: "name", key: "key"),
    Video(id: "id", name: "name", key: "key"),
    Video(id: "id", name: "name", key: "key"),
  ];

  group('singleList Widget', () {
    testWidgets('Widget displays correct number of items and performs',
        (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          GetMaterialApp(
            routes: {
              SINGLE_CAST_SCREEN: (context) => SingleCastScreenTest(),
            },
            home: Scaffold(
              body: singleList(testCasts),
            ),
            onGenerateRoute: (settings) {
              if (settings.name == SINGLE_CAST_SCREEN) {
                expect(settings.arguments, ScreenArguments('Actor 1', 1));
                return MaterialPageRoute(
                    builder: (_) => SingleCastScreenTest());
              }
              return null;
            },
          ),
        );
      });
      expect(find.byKey(Key("single_list_casts")), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(3));
      await tester.tap(find.byType(GestureDetector).at(0));
      await tester.pumpAndSettle();
      expect(find.byKey(Key("single_list_casts")), findsNothing);
      expect(find.byKey(Key("test class")), findsOneWidget);
    });
  });

  group("single video widget test", () {
    testWidgets("Testing the videos", (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: singleListVideos(testVideos),
          ),
        ));
      });
      expect(find.byKey(Key("single_list_video")), findsOneWidget);
      expect(find.byKey(Key("single_video_img")), findsNWidgets(4));
      await tester.tap(find.byKey(Key("single_video_img")).at(0));
      await tester.pumpAndSettle();
      // expect(find.byKey(Key("single_list_casts")), findsNothing);
      // expect(find.byKey(Key("test class")), findsOneWidget);
    });
  });
}

Widget SingleCastScreenTest() {
  return Text(
    "test",
    key: Key("test class"),
  );
}
