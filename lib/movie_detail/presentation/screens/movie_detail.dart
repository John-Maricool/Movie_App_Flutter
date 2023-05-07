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

  final args = Get.arguments as MovieDetailArgument;
  final MovieDetailController _controller = Get.find<MovieDetailController>();

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
              Obx(() {
                if (_controller.stateDetail is FinishedState) {
                  MovieDetail detail = _controller.detail as MovieDetail;
                  return movieDetails(
                      context,
                      detail.backdrop_path,
                      detail.title,
                      detail.original_language,
                      detail.runtime.toString(),
                      detail.release_date,
                      detail.vote_average,
                      detail.vote_count,
                      detail.genres.map((genre) => genre?.name).toList(),
                      detail.overview);
                }
                if (_controller.stateDetail is LoadingState) {
                  return progressBar();
                }
                if (_controller.stateDetail ==
                    ErrorState(errorType: InternetError())) {
                  return noInternet(() {});
                }
                return Container();
              }),
              const Padding(padding: EdgeInsets.all(15)),
              Obx(() {
                if (_controller.state2 is FinishedState) {
                  return Padding(
                      padding: EdgeInsets.only(left: 10), child: showVideos());
                }
                if (_controller.state2 is LoadingState) {
                  return progressBar();
                }
                if (_controller.state2 ==
                    ErrorState(errorType: InternetError())) {
                  return noInternet(() {});
                }
                return Container();
              }),
              const Padding(padding: EdgeInsets.all(15)),
              Obx(() {
                if (_controller.state1 is FinishedState) {
                  return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: showCasts());
                }
                if (_controller.state1 is LoadingState) {
                  return progressBar();
                }
                if (_controller.state1 ==
                    ErrorState(errorType: InternetError())) {
                  return noInternet(() {});
                }
                return Container();
              }),
              const Padding(padding: EdgeInsets.all(5)),
            ],
          ),
        ));
  }

  Widget movieDetails(
      BuildContext context,
      String? url,
      String? title,
      String? language,
      String? time,
      String? date,
      double? rating,
      int? votes,
      List<String?> genre,
      String? desc) {
    return Column(
      children: [
        url != null
            ? Image.network(
                url,
                width: MediaQuery.of(context).size.width,
                height: 250,
              )
            : Container(),
        movieTitleAndDetails(context, title, language, time, date),
        genresMovieDetail(genre),
        ratings(rating, votes),
        const Padding(padding: EdgeInsets.only(top: 12)),
        desc != null
            ? Text(
                desc,
                style: const TextStyle(color: whiteColor, fontSize: 15),
              )
            : Container()
      ],
    );
  }

  Widget showCasts() {
    return Column(
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
    );
  }

  Widget showVideos() {
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "VIDEOS",
              style: TextStyle(color: whiteColor, fontSize: 16),
            )),
        singleListVideos(_controller.data2)
      ],
    );
  }
}

class MovieDetailArgument {
  final int id;
  final String name;

  MovieDetailArgument(this.id, this.name);
}
