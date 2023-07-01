import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constant.dart';

Widget noInternet(VoidCallback startShoppingClicked) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    key: Key("no_internet"),
    children: [
      const Icon(
        Icons.signal_wifi_connected_no_internet_4,
        size: 40,
        color: redColor,
      ),
      const Padding(padding: EdgeInsets.only(top: 10)),
      const Text(
        'Oops!',
        style: TextStyle(
            color: whiteColor,
            fontSize: smallTextFontSize,
            fontWeight: FontWeight.bold),
      ),
      const Padding(padding: EdgeInsets.only(top: 10)),
      const Text(
        'Please check your Internet connection and try again',
        style: TextStyle(color: whiteColor, fontSize: 15),
      ),
      const Padding(padding: EdgeInsets.only(top: 30)),
      defaultButtons(
          pressed: startShoppingClicked,
          text: 'Try Again',
          size: const Size(120, 50))
    ],
  );
}

Widget defaultButtons(
    {required VoidCallback pressed,
    required String text,
    Size size = fullWidthButtonSize}) {
  return ElevatedButton(
      onPressed: pressed,
      style: ElevatedButton.styleFrom(
          primary: redColor, minimumSize: size, shadowColor: redColor),
      child: Text(
        text,
        style: const TextStyle(color: whiteColor, fontSize: smallTextFontSize),
      ));
}

Widget showEmptyResult(BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.hourglass_empty,
            size: 40,
            color: redColor,
          ),
          Text(
            'No results',
            textAlign: TextAlign.center,
            style: TextStyle(color: whiteColor, fontSize: smallTextFontSize),
          )
        ],
      ));
}

Widget progressBar() {
  return const Center(
      key: Key("progress_bar"),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: redColor,
      ));
}

PreferredSizeWidget customAppBar(
    {required String text,
    required VoidCallback onPressed,
    List<Widget>? actions}) {
  return AppBar(
    elevation: 0.0,
    title: Text(
      text,
      style: const TextStyle(color: whiteColor, fontSize: 18.0),
    ),
    backgroundColor: blackColor,
    actions: actions,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: whiteColor,
        size: 17.0,
      ),
    ),
  );
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

Widget genresMovieDetail(List<String?>? genre) {
  return genre != null
      ? Row(
          children: List.generate(
            genre.length,
            (index) => Row(
              children: [
                Text(
                  "${genre[index]}/",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ), // Add spacing between items
              ],
            ),
          ),
        )
      : Container();
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
