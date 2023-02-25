// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/constants/route_constants.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/presentation/screens/home.dart';
import 'package:movie_app/tv_shows/presentation/controller/tv_list_controller.dart';

class TvShowsScreen extends StatelessWidget {
  TvShowsScreen({Key? key}) : super(key: key);
  final TvListController _controller = Get.find<TvListController>();

  @override
  Widget build(BuildContext context) {
    _controller.getMovies();
    return Scaffold(
      appBar: customAppBar(onPressed: () {}, text: "Tv Shows"),
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
          return showGrid(
            res,
            titles,
          );
        }
        return progressBar();
      }),
    );
  }

  Widget bottomNavDrawer() {
    return BottomNavigationBar(
      currentIndex: 2,
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
          _controller.onClose();
          Get.toNamed(MOVIES_ROUTE);
        } else {
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

  Widget showGrid(List<String?> imageUrls, List<String?> titles) {
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
            return CurvedImage(
              imageUrl: imageUrls[index],
              text: titles[index],
            );
          }
        });
  }
}
