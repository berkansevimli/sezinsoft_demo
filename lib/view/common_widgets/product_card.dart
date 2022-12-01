import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utilities/asset_utils.dart';
import '../../core/utilities/color_utils.dart';
import '../../core/utilities/font_style_utils.dart';
import 'custom_button.dart';
import 'custom_image_view.dart';
import 'custom_svg_view.dart';

/// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final int? itemCount;
  final VoidCallback? onCardPress;
  final VoidCallback? onBook;
  final String? distance;
  final double? width;
  final VoidCallback? onFavoriteTap;

  /// THIS "cardType" IS USED TO DEFINE TYPE OF CARD.
  /// YOU CAN USE ProductCardTypes.showStars TO SHOW DETAILS STARS
  /// YOU CAN USE ProductCardTypes.showButton TO GET ON TAP CALLBACK
  /// YOU CAN USE ProductCardTypes.showFavorite TO GET FAVORITE ICON
  ProductCard({
    Key? key,
    this.image,
    this.title,
    this.description,
    this.itemCount,
    this.distance,
    this.width,
    this.onBook,
    this.onFavoriteTap,
    this.onCardPress,
  }) {}

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onCardPress ?? () {},
      child: Container(
        height: 110,
        width: width ?? screenSize.width,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: ColorUtilities.light_200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CustomImageView(
              imageUrl: image,
              width: 95,
              height: 85,
              isFromAssets: false,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(20),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: FontStyleUtilities.t1(
                      fontColor: ColorUtilities.text_900,
                      fontWeight: FWT.semiBold,
                    ),
                  ),
                  Text(
                    description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: FontStyleUtilities.t1(
                      fontColor: ColorUtilities.text_300,
                      fontWeight: FWT.bold,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              buttonSize: ButtonSize.small,
              preffixIcon: AssetUtilities.plusStrokeSvg,
              title: "Ekle",
              onButtonTap: onBook ?? () {},
            )
          ],
        ),
      ),
    );
  }
}
