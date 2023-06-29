import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/presentation/controller/home_controller.dart';
import 'package:movie_app/home/presentation/screens/home.dart';

import '../controller/home_controller_test.mocks.dart';
import 'home_test.mocks.dart';

class HomeControllerTest extends Mock implements HomeController {}

@GenerateMocks([HomeControllerTest])
void main() {
  group('Testing Popular movies widget', () {
    testWidgets('Widget renders correctly in finished state',
        (WidgetTester tester) async {
      final HomeControllerImpl controller = Get.put(HomeControllerImpl(
          usecase: MockHomeCategoryUsecaseTest(),
          detailUsecase: MockMovieDetailUsecaseTest()));

      //  when(controller.state1).thenReturn(FinishedState());
      when(controller.data1).thenReturn([
        MovieListItemModel(id: 1, title: 'Movie 1', image: 'image1.jpg'),
        MovieListItemModel(id: 2, title: 'Movie 2', image: 'image2.jpg'),
      ]);

      // Build the widget with the mock controller
      //   await tester.pumpWidget(
      // MaterialApp(
      //     home: Scaffold(body: HomeScreen().popular(controller)),
      //  ),
      // );

      // Verify that the widget renders the expected UI elements
      //    expect(find.text('Popular'), findsOneWidget);
      //  expect(find.byType(singleList as Type), findsOneWidget);
      //   expect(find.byType(progressBar as Type), findsNothing);
      // expect(find.byType(noInternet as Type), findsNothing);
    });
  });
}
