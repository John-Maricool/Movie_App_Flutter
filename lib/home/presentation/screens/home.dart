import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/constants/route_constants.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/home/presentation/controller/home_controller.dart';
import 'package:movie_app/home/presentation/screens/custom_widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    _controller.getPopularMovies();
    _controller.getInTheatreMovies();
    _controller.getUpcomingMovies();
    return Scaffold(
      backgroundColor: blackColor,
      appBar: customAppBar(text: "Home", onPressed: () {}),
      bottomNavigationBar: bottomNavDrawer(),
      body: Column(
        children: [
          header(context),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        popular(),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        inTheatre(),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        upcoming()
                      ]))))
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Obx(() {
      if (_controller.stateDetail is FinishedState) {
        final url = _controller.detail.backdrop_path;
        final text = _controller.detail.title;
        final genre = _controller.detail.genres;
        final genreNames = genre.map((genre) => genre?.name).toList();
        final rating = _controller.detail.vote_average;
        final votes = _controller.detail.vote_count;
        return Column(children: [
          topHomeView(url, text, genreNames, context),
          //   Container(padding: EdgeInsets.all(5), child: genres(genreNames)),
          const Padding(padding: EdgeInsets.only(top: 5)),
          Container(padding: EdgeInsets.all(5), child: ratings(rating, votes))
        ]);
      }
      if (_controller.stateDetail is LoadingState) {
        return progressBar();
      }
      if (_controller.stateDetail == ErrorState(errorType: InternetError())) {
        return noInternet(() {});
      }
      return Container();
    });
  }

  Widget bottomNavDrawer() {
    return BottomNavigationBar(
      currentIndex: 0,
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
          Get.toNamed(HOME_ROUTE);
        } else if (value == 1) {
          _controller.onClose();
          Get.toNamed(MOVIES_ROUTE);
        } else {
          _controller.onClose();
          Get.toNamed(TV_SHOWS_ROUTE);
        }
      },
      type: BottomNavigationBarType.fixed,
    );
  }

  Widget popular() {
    return Column(children: [
      singleListHeader("Popular"),
      const Padding(padding: EdgeInsets.only(top: 5)),
      Obx(() {
        if (_controller.state1 is FinishedState) {
          return singleList(_controller.data1);
        }
        if (_controller.state1 is LoadingState) {
          return progressBar();
        }
        if (_controller.state1 == ErrorState(errorType: InternetError())) {
          return noInternet(() {});
        }
        return Container();
      })
    ]);
  }

  Widget upcoming() {
    return Column(children: [
      singleListHeader("Upcoming"),
      const Padding(padding: EdgeInsets.only(top: 5)),
      Obx(() {
        if (_controller.state3 is FinishedState) {
          return singleList(_controller.data3);
        }
        if (_controller.state3 is LoadingState) {
          return progressBar();
        }
        if (_controller.state3 == ErrorState(errorType: InternetError())) {
          return noInternet(() {});
        }
        return Container();
      }),
    ]);
  }

  Widget inTheatre() {
    return Column(children: [
      singleListHeader("In Theatre"),
      const Padding(padding: EdgeInsets.only(top: 5)),
      Obx(() {
        if (_controller.state2 is FinishedState) {
          return singleList(_controller.data2);
        }
        if (_controller.state2 is LoadingState) {
          return progressBar();
        }
        if (_controller.state2 == ErrorState(errorType: InternetError())) {
          return noInternet(() {});
        }
        return Container();
      }),
    ]);
  }

  BottomNavigationBarItem bottomNavItem(IconData data, String label) {
    return BottomNavigationBarItem(
      icon: Icon(data),
      label: label,
    );
  }
}
