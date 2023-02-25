import 'package:flutter/material.dart';
import 'package:movie_app/core/constant.dart';

class CurvedImage extends StatelessWidget {
  final String? imageUrl;
  final String? text;

  const CurvedImage({Key? key, required this.imageUrl, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
          child: Image.network(
        imageUrl!,
        width: 90,
        height: 120,
        fit: BoxFit.cover,
      )),
      const Padding(padding: EdgeInsets.only(top: 5)),
      text != null
          ? SizedBox(
              width: 90,
              child: Text(
                text!,
                maxLines: 2,
                style: const TextStyle(fontSize: 12, color: whiteColor),
              ))
          : Container(),
      const Padding(padding: EdgeInsets.only(top: 15)),
    ]);
  }
}
