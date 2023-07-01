import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/constants/route_constants.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';
import 'package:movie_app/movie_detail/data/model/cast.dart';
import 'package:movie_app/movie_detail/data/model/video.dart';
import 'package:movie_app/single_cast_detail/presentation/screens/single_cast_screen.dart';
import 'package:url_launcher/url_launcher.dart';

Widget singleList(List<Cast> movies) {
  return SizedBox(
      key: Key("single_list_casts"),
      height: 130,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) =>
              const Padding(padding: EdgeInsets.only(right: 8)),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            List<String?> res = movies.map((obj) => obj.profile_path).toList();
            List<String?> titles = movies.map((obj) => obj.name).toList();
            return GestureDetector(
                child: CurvedImage(imageUrl: res[index], text: titles[index]),
                onTap: () {
                  Get.toNamed(SINGLE_CAST_SCREEN,
                      arguments: ScreenArguments(
                          movies[index].name, movies[index].id));
                });
          }));
}

Widget singleListVideos(List<Video> movies) {
  return SizedBox(
      key: Key("single_list_video"),
      height: 90,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) =>
              const Padding(padding: EdgeInsets.only(right: 8)),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            List<String?> res = movies.map((obj) => obj.key).toList();
            return singleVideoImg(() {
              String youtubeUrl =
                  'https://www.youtube.com/watch?v=${res[index]}';
              launchUrl(Uri.parse(youtubeUrl));
            }, res[index]);
          }));
}

Widget singleVideoImg(VoidCallback onclick, String? img) {
  return GestureDetector(
      key: Key("single_video_img"),
      onTap: () {
        onclick();
      },
      child: Stack(
        children: [
          Image.network(
            "https://img.youtube.com/vi/" + img! + "/hqdefault.jpg",
            width: 120,
            height: 90,
            fit: BoxFit.cover,
          ),
          const Positioned(
              top: 1,
              bottom: 1,
              left: 1,
              right: 1,
              child: Center(
                  child: Icon(
                Icons.play_circle,
                size: 45,
                color: Colors.black,
              )))
        ],
      ));
}

Widget singleIcon(BuildContext context, IconData data, String value) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Row(
        children: [
          Icon(
            data,
            size: 15,
            color: whiteColor,
          ),
          const Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            value,
            style: const TextStyle(color: whiteColor, fontSize: 14),
          )
        ],
      ));
}

Widget movieDetailInIcon(
    BuildContext context, String? language, String? time, String? date) {
  return Column(
    children: [
      language != null
          ? singleIcon(context, Icons.lan_sharp, language)
          : Container(),
      time != null
          ? singleIcon(context, Icons.timeline_rounded, time + "mins")
          : Container(),
      date != null
          ? singleIcon(context, Icons.date_range_sharp, date)
          : Container()
    ],
  );
}

Widget movieDetailInIconTv(
    BuildContext context, String? date, String? episodes, String? seasons) {
  return Column(
    children: [
      date != null
          ? singleIcon(context, Icons.date_range_rounded, date)
          : Container(),
      episodes != null
          ? singleIcon(context, Icons.timeline_rounded, "Episodes $episodes")
          : Container(),
      seasons != null
          ? singleIcon(context, Icons.date_range_sharp, "Seasons: $seasons")
          : Container()
    ],
  );
}

Widget movieTitleAndDetails(BuildContext context, String? title,
    String? language, String? time, String? date) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: title != null
              ? Text(
                  title,
                  style: const TextStyle(fontSize: 26, color: whiteColor),
                )
              : Container(),
        ),
        movieDetailInIcon(context, language, time, date)
      ],
    ),
  );
}

Widget movieTitleAndDetailsTv(BuildContext context, String? title, String? date,
    String? episodes, String? seasons) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: title != null
              ? Text(
                  title,
                  style: const TextStyle(fontSize: 26, color: whiteColor),
                )
              : Container(),
        ),
        movieDetailInIconTv(context, date, episodes, seasons)
      ],
    ),
  );
}
