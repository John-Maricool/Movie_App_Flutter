import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';

void main() {
  testWidgets('CurvedImage displays image when imageUrl is provided',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      const img = MaterialApp(
          home: Scaffold(
              body: CurvedImage(
        imageUrl: 'https://example.com/image.jpg',
        text: 'Example Text',
      )));

      await tester.pumpWidget(img);
    });
    // Verify that the image is displayed
    expect(find.byType(Image), findsOneWidget);

    // Verify that the provided text is displayed
    expect(find.text('Example Text'), findsOneWidget);
  });

  testWidgets('CurvedImage displays "No Image" text when imageUrl is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CurvedImage(
            imageUrl: null,
            text: 'Example Text',
          ),
        ),
      ),
    );

    // Verify that the "No Image" text is displayed
    expect(find.text('No Image'), findsOneWidget);

    // Verify that the provided text is displayed
    expect(find.text('Example Text'), findsOneWidget);
  });
}
