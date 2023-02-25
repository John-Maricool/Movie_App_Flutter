import 'package:flutter/material.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';

class MyGridView extends StatelessWidget {
  final List<String?> imageUrls;
  final List<String?> titles;

  const MyGridView({Key? key, required this.imageUrls, required this.titles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        clipBehavior: Clip.none,
        itemCount: imageUrls.length, // number of items in your list
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return CurvedImage(
            imageUrl: imageUrls[index],
            text: titles[index],
          ); // replace with your own image widget
        });
  }
}
