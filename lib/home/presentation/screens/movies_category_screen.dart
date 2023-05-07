import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/constants/route_constants.dart';
import 'package:movie_app/home/presentation/controller/movie_category_controller.dart';
import 'package:movie_app/movie_detail/presentation/screens/movie_detail.dart';
import '../../../core/error_types/error_types.dart';
import '../../../core/reusable_widgets/curved_image.dart';
import '../../../core/reusable_widgets/reusable_widgets.dart';
import '../../../core/state/state.dart';

class MoviesCategoryScreen extends StatelessWidget {
  MoviesCategoryScreen({Key? key}) : super(key: key);

  final MovieCategoryController _controller =
      Get.find<MovieCategoryController>();

  final args = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    _controller.getMovieCategory(args);
    return Scaffold(
      appBar: customAppBar(
          onPressed: () {
            Get.back();
            _controller.onClose();
          },
          text: args),
      backgroundColor: blackColor,
      body: Obx(() {
        if (_controller.state1 == ErrorState(errorType: EmptyListError())) {
          return showEmptyResult(context);
        }
        if (_controller.state1 == ErrorState(errorType: InternetError())) {
          return noInternet(() {
            _controller.getMovieCategory(args);
          });
        }
        if (_controller.state1 is FinishedState) {
          List<String?> res =
              _controller.data1.map((obj) => obj.image).toList();
          List<String?> titles =
              _controller.data1.map((obj) => obj.title).toList();
          return showGrid(res, titles, (index) {
            final id = _controller.data1[index].id;
            Get.toNamed(MOVIE_DETAILS_ROUTE,
                arguments: MovieDetailArgument(id, titles[index]!));
          });
        } else {
          return Container();
        }
      }),
    );
  }

  Widget showGrid(
      List<String?> imageUrls, List<String?> titles, Function(int) onClick) {
    return GridView.builder(
        clipBehavior: Clip.none,
        itemCount: _controller.isLast == true
            ? imageUrls.length
            : imageUrls.length + 1, // number of items in your list
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (index == imageUrls.length) {
            _controller.fetchItems(args);
            return progressBar();
          } else {
            return GestureDetector(
              child: CurvedImage(
                imageUrl: imageUrls[index],
                text: titles[index],
              ),
              onTap: () {
                onClick(index);
              },
            );
          }
        });
  }
}
