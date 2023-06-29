import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';
import 'package:movie_app/home/presentation/screens/custom_widgets.dart';

void main() {
  group('singleList Widget', () {
    final movies = [
      MovieListItemModel(id: 1, title: 'Movie 1', image: 'image1.jpg'),
      MovieListItemModel(id: 2, title: 'Movie 2', image: 'image2.jpg'),
    ];
    testWidgets('Widget renders without errors', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: singleList(movies, (id, title) {}),
          ),
        );
      });
      expect(find.byType(Image), findsNWidgets(movies.length));
      expect(find.byType(Text), findsNWidgets(movies.length));
    });

    testWidgets('Tap on movie item triggers onClick function',
        (WidgetTester tester) async {
      int tappedId = 1;
      String tappedTitle = 'Movie 1';
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: singleList(
              movies,
              (id, title) {
                tappedId = id;
                tappedTitle = title;
              },
            ),
          ),
        );
      });

      await tester.tap(find.byType(CurvedImage).first);
      await tester.pump();

      expect(tappedId, equals(movies[0].id));
      expect(tappedTitle, equals(movies[0].title));
    });
  });
}
