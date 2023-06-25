import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/movie_detail/data/model/tv_detail.dart';
import 'package:movie_app/movie_detail/presentation/controller/tv_detail_controller.dart';
import 'package:movie_app/movie_detail/presentation/screens/custom_widgets.dart';
import 'package:movie_app/movie_detail/presentation/screens/movie_detail.dart';

class TvDetailScreen extends StatelessWidget {
  TvDetailScreen({Key? key}) : super(key: key);

  final args = Get.arguments as MovieDetailArgument;
  final TvDetailController _controller = Get.find<TvDetailController>();

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
                  TvDetail result = _controller.detail as TvDetail;
                  return movieDetails(
                      context,
                      result.backdrop_path,
                      result.original_name,
                      result.first_air_date,
                      result.number_of_episodes.toString(),
                      result.number_of_seasons.toString(),
                      result.vote_average,
                      result.vote_count,
                      result.genres?.map((genre) => genre?.name).toList(),
                      result.overview);
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
              const Padding(padding: EdgeInsets.all(10)),
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
              const Padding(padding: EdgeInsets.all(15)),
            ],
          ),
        ));
  }

  Widget movieDetails(
      BuildContext context,
      String? url,
      String? title,
      String? date,
      String? episodes,
      String? seasons,
      double? rating,
      int? votes,
      List<String?>? genre,
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
        movieTitleAndDetailsTv(context, title, date, episodes, seasons),
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
    if (_controller.data1.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(10),
      );
    }
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "CASTS",
              style: TextStyle(color: whiteColor, fontSize: 16),
            )),
        singleList(_controller.data1)
      ],
    );
  }

  Widget showVideos() {
    if (_controller.data2.isEmpty) {
      return Container();
    }
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
