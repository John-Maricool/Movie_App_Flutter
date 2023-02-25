import 'package:flutter/material.dart';

import '../constant.dart';

Widget noInternet(VoidCallback startShoppingClicked) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
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
