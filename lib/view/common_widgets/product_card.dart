import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sezinsoft_demo/size_config.dart';

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
  final VoidCallback onAdd;
  final VoidCallback onMinusTap;
  final VoidCallback onPlusTap;

  final String? distance;
  final double? width;

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
    required this.onAdd,
    required this.onMinusTap,
    required this.onPlusTap,
  }) {}

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        height: 110,
        width: width ?? screenSize.width,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
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
            const SizedBox(width: 15),
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
            itemCount != 0
                ? buildCounter()
                : CustomButton(
                    buttonSize: ButtonSize.small,
                    preffixIcon: AssetUtilities.plusStrokeSvg,
                    title: "Ekle",
                    onButtonTap: onAdd,
                  )
          ],
        ),
      ),
    );
  }

  Container buildCounter() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(12))),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFF411c41),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(getProportionateScreenWidth(12)),
                    bottomLeft:
                        Radius.circular(getProportionateScreenWidth(12)))),
            child: InkWell(
              onTap: onMinusTap,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: CustomSvgView(
                  imageUrl: "assets/icons/svg/stroke/minus.svg",
                  isFromAssets: true,
                  svgColor: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8)),
            child: Text(itemCount.toString()),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFF411c41),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(getProportionateScreenWidth(12)),
                    bottomRight:
                        Radius.circular(getProportionateScreenWidth(12)))),
            child: InkWell(
              onTap: onPlusTap,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: CustomSvgView(
                  imageUrl: "assets/icons/svg/stroke/plus_svg.svg",
                  isFromAssets: true,
                  svgColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
