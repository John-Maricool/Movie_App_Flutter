import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/movie_detail/data/model/movie_detail.dart';
import 'package:movie_app/movie_detail/presentation/controller/movie_detail_controller.dart';
import 'package:movie_app/movie_detail/presentation/screens/custom_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({Key? key}) : super(key: key);

  final MovieDetailController _controller = Get.find<MovieDetailController>();

  final args = MovieDetailArgument(2, "");

  @override
  Widget build(BuildContext context) {
    _controller.setId(args.id);
    return Scaffold(
        appBar: customAppBar(
            text: args.name,
            onPressed: () {
              _controller.onClose();
              Get.back();
            }),
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              movieDetails(context),
              const Padding(padding: EdgeInsets.all(15)),
              showVideos(),
              const Padding(padding: EdgeInsets.all(15)),
              showCasts(),
              const Padding(padding: EdgeInsets.all(5)),
            ],
          ),
        ));
  }

  Widget movieDetails(BuildContext context) {
    return Obx(() {
      if (_controller.stateDetail is FinishedState) {
        MovieDetail detail = _controller.detail as MovieDetail;
        Column(
          children: [
            detail.backdrop_path != null
                ? Image.network(
                    detail.backdrop_path!,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  )
                : Container(),
            movieTitleAndDetails(
                context,
                detail.title,
                detail.original_language,
                detail.runtime.toString(),
                detail.release_date),
            genresMovieDetail(
              detail.genres!.map((genre) => genre.name).toList(),
            ),
            ratings(detail.vote_average, detail.vote_count),
            const Padding(padding: EdgeInsets.only(top: 12)),
            detail.overview != null
                ? Text(
                    detail.overview!,
                    style: const TextStyle(color: whiteColor, fontSize: 15),
                  )
                : Container()
          ],
        );
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

  Widget showCasts() {
    return Obx(() {
      if (_controller.state1 is FinishedState) {
        return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "CASTS",
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ),
                singleList(_controller.data1)
              ],
            ));
      }
      if (_controller.state1 is LoadingState) {
        return progressBar();
      }
      if (_controller.state1 == ErrorState(errorType: InternetError())) {
        return noInternet(() {});
      }
      return Container();
    });
  }

  Widget showVideos() {
    return Obx(() {
      if (_controller.state2 is FinishedState) {
        return Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "VIDEOS",
                      style: TextStyle(color: whiteColor, fontSize: 16),
                    )),
                singleListVideos(_controller.data2)
              ],
            ));
      }
      if (_controller.state2 is LoadingState) {
        return progressBar();
      }
      if (_controller.state2 == ErrorState(errorType: InternetError())) {
        return noInternet(() {});
      }
      return Container();
    });
  }
}

class MovieDetailArgument {
  final int id;
  final String name;

  MovieDetailArgument(this.id, this.name);
}
