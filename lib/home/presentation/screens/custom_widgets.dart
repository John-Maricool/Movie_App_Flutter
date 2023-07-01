import 'package:flutter/material.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';

Widget singleListHeader(String category, VoidCallback onClick) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(
      category,
      style: const TextStyle(
          color: whiteColor, fontSize: 15, fontWeight: FontWeight.bold),
    ),
    GestureDetector(
      child: const Text(
        "show all",
        style: TextStyle(color: whiteColor, fontSize: 13),
      ),
      onTap: () {
        onClick();
      },
    )
  ]);
}

Widget singleList(
    List<MovieListItemModel> movies, Function(int, String) onClick) {
  return SizedBox(
      key: Key("single_list"),
      height: 150,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) =>
              const Padding(padding: EdgeInsets.only(right: 8)),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            List<String?> res = movies.map((obj) => obj.image).toList();
            List<String?> titles = movies.map((obj) => obj.title).toList();
            return GestureDetector(
              onTap: () {
                final id = movies[index].id;
                final title = movies[index].title;
                onClick(id, title);
              },
              child: CurvedImage(imageUrl: res[index], text: titles[index]),
            );
          }));
}

Widget topHomeView(
    String? url, String? text, List<String?> genre, BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(clipBehavior: Clip.none, children: <Widget>[
        Image.network(
          url!,
          width: MediaQuery.of(context).size.width,
          height: 250,
        ),
        Positioned(
            bottom: 30,
            child: Text(
              text!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
        Positioned(bottom: 1, child: genres(genre))
      ]));
}
