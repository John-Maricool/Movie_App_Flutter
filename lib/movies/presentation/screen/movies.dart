import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/constants/route_constants.dart';
import 'package:movie_app/movie_detail/presentation/screens/movie_detail.dart';
import 'package:movie_app/movies/presentation/controllers/movie_list_controller.dart';
import 'package:movie_app/tv_shows/presentation/screen/tv_shows.dart';
import '../../../core/error_types/error_types.dart';
import '../../../core/reusable_widgets/curved_image.dart';
import '../../../core/reusable_widgets/reusable_widgets.dart';
import '../../../core/reusable_widgets/my_grid.dart';
import '../../../core/state/state.dart';
import '../../../home/presentation/screens/home.dart';

class MoviesScreen extends StatelessWidget {
  MoviesScreen({Key? key}) : super(key: key);

  final MovieListController _controller = Get.find<MovieListController>();
  @override
  Widget build(BuildContext context) {
    _controller.getMovies();
    return Scaffold(
      appBar: customAppBar(onPressed: () {}, text: "Movies"),
      backgroundColor: blackColor,
      bottomNavigationBar: bottomNavDrawer(),
      body: Obx(() {
        if (_controller.state == ErrorState(errorType: EmptyListError())) {
          return showEmptyResult(context);
        }
        if (_controller.state == ErrorState(errorType: InternetError())) {
          return noInternet(() {
            _controller.getMovies();
          });
        }
        if (_controller.state is FinishedState) {
          List<String?> res = _controller.data.map((obj) => obj.image).toList();
          List<String?> titles =
              _controller.data.map((obj) => obj.title).toList();
          return showGrid(res, titles, (index) {
            final id = _controller.data[index].id;
            Get.toNamed(MOVIE_DETAILS_ROUTE,
                arguments: MovieDetailArgument(id, titles[index]!));
          });
        }
        return progressBar();
      }),
    );
  }

  Widget bottomNavDrawer() {
    return BottomNavigationBar(
      currentIndex: 1,
      items: [
        bottomNavItem(Icons.home, 'Home'),
        bottomNavItem(Icons.movie_sharp, 'Movies'),
        bottomNavItem(Icons.tv_sharp, 'Tv Shows'),
      ],
      unselectedItemColor: whiteColor,
      backgroundColor: blackColor,
      selectedItemColor: redColor,
      onTap: (value) {
        if (value == 0) {
          _controller.onClose();
          Get.toNamed(HOME_ROUTE);
        } else if (value == 1) {
          Get.toNamed(MOVIES_ROUTE);
        } else {
          _controller.onClose();
          Get.toNamed(TV_SHOWS_ROUTE);
        }
      },
      type: BottomNavigationBarType.fixed,
    );
  }

  BottomNavigationBarItem bottomNavItem(IconData data, String label) {
    return BottomNavigationBarItem(
      icon: Icon(data),
      label: label,
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
            _controller.fetchItems();
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
