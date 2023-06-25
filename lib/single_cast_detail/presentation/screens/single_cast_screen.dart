import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/constant.dart';
import 'package:movie_app/core/data_model/movei_list_item_model.dart';
import 'package:movie_app/core/error_types/error_types.dart';
import 'package:movie_app/core/reusable_widgets/curved_image.dart';
import 'package:movie_app/core/reusable_widgets/reusable_widgets.dart';
import 'package:movie_app/core/state/state.dart';
import 'package:movie_app/single_cast_detail/presentation/controller/single_cast_controller.dart';

class SingleCastScreen extends StatelessWidget {
  SingleCastScreen({Key? key}) : super(key: key);

  final SingleCastController _controller = Get.find<SingleCastController>();
  final ScreenArguments args = Get.arguments as ScreenArguments;
  @override
  Widget build(BuildContext context) {
    _controller.setId(args.id);
    return Scaffold(
      backgroundColor: blackColor,
      appBar: customAppBar(
          text: args.title,
          onPressed: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Obx(() {
          if (_controller.stateDetail is LoadingState) {
            return progressBar();
          }
          if (_controller.stateDetail ==
              ErrorState(errorType: InternetError())) {
            return noInternet(() {
              _controller.setId(args.id);
            });
          }
          if (_controller.stateDetail is FinishedState) {
            final details = _controller.detail;
            return Column(
              children: [
                userDetails(
                    details.image, details.name, details.role, details.desc),
                showImages(details.images),
                showCredits(details.movie)
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }

  final padding = const Padding(padding: EdgeInsets.all(10));

  Widget userDetails(String? image, String? name, String? role, String? desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48),
            child: Image.network(image!, fit: BoxFit.cover),
          ),
        ),
        padding,
        Text(
          name!,
          style: const TextStyle(
              color: whiteColor,
              fontSize: smallTextFontSize,
              fontWeight: FontWeight.bold),
        ),
        padding,
        Text(role!,
            style: TextStyle(color: whiteColor, fontSize: smallTextFontSize)),
        padding,
        Text(desc!,
            style: TextStyle(color: whiteColor, fontSize: smallerTextFontSize))
      ],
    );
  }

  Widget showImages(List<String>? images) {
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "CASTS",
              style: TextStyle(color: whiteColor, fontSize: 16),
            )),
        SizedBox(
            height: 130,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(padding: EdgeInsets.only(right: 8)),
                itemCount: images!.length,
                itemBuilder: (context, index) {
                  return CurvedImage(imageUrl: images[index], text: "");
                }))
      ],
    );
  }
}

Widget showCredits(List<MovieListItemModel>? images) {
  return Column(
    children: [
      const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "CREDITS",
            style: TextStyle(color: whiteColor, fontSize: 16),
          )),
      SizedBox(
          height: 130,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  const Padding(padding: EdgeInsets.only(right: 8)),
              itemCount: images!.length,
              itemBuilder: (context, index) {
                return CurvedImage(
                    imageUrl: images[index].image, text: images[index].title);
              }))
    ],
  );
}

class ScreenArguments {
  final String title;
  final int id;

  ScreenArguments(this.title, this.id);
}
