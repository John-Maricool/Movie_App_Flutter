import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';

Widget singleListHeader(String category) {
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
      onTap: () {},
    )
  ]);
}

Widget singleList(List<MovieListItemModel> movies) {
  return SizedBox(
      height: 150,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) =>
              const Padding(padding: EdgeInsets.only(right: 8)),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            List<String?> res = movies.map((obj) => obj.image).toList();
            List<String?> titles = movies.map((obj) => obj.title).toList();
            return CurvedImage(imageUrl: res[index], text: titles[index]);
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

Widget genres(List<String?> genre) {
  return Row(
    children: List.generate(
      genre.length,
      (index) => SizedBox(
        height: 25,
        child: Row(
          children: [
            Container(
              color: Colors.red,
              padding: const EdgeInsets.all(2),
              child: Text(
                genre[index] ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
            ), // Add spacing between items
          ],
        ),
      ),
    ),
  );
}

Widget ratings(double? rating, int? votes) {
  return Row(
    children: [
      RatingBar.builder(
        itemSize: 13,
        initialRating: rating ?? 0,
        minRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.red,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
      const Padding(padding: EdgeInsets.only(left: 10)),
      Text(
        "$votes votes",
        style: const TextStyle(color: whiteColor, fontSize: 14),
      )
    ],
  );
}
