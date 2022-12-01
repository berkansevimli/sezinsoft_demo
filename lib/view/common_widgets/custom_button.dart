import 'package:flutter/material.dart';

import '../../core/utilities/color_utils.dart';
import '../../core/utilities/font_style_utils.dart';
import 'custom_svg_view.dart';

enum ButtonSize {
  small,
  medium,
  big,
}

/// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final String? secondTitle;
  final String? preffixIcon;
  final String? suffixIcon;
  final bool? isFlatButton;
  final Color? buttonColor;
  final double? buttonRadius;
  final ButtonSize? buttonSize;
  final VoidCallback? onButtonTap;
  final bool isLoading;
  CustomButton(
      {Key? key,
      this.height,
      this.width,
      this.title,
      this.preffixIcon,
      this.suffixIcon,
      this.isFlatButton = false,
      this.buttonColor = const Color(0xFF411c41),
      this.buttonSize = ButtonSize.big,
      this.onButtonTap,
      this.secondTitle,
      this.isLoading = false,
      this.buttonRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: height ??
            ((buttonSize == ButtonSize.big)
                ? 58
                : (buttonSize == ButtonSize.medium)
                    ? 48
                    : 28),
        width: width,
        decoration: BoxDecoration(
          color: isFlatButton!
              ? ColorUtilities.transparant
              : buttonColor ?? ColorUtilities.primary_500,
          border: isFlatButton!
              ? Border.all(color: Theme.of(context).cardColor)
              : null,
          borderRadius: BorderRadius.circular(buttonRadius != null
              ? buttonRadius!
              : (buttonSize == ButtonSize.big)
                  ? 10
                  : (buttonSize == ButtonSize.medium)
                      ? 10
                      : 7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            preffixIcon != null
                ? CustomSvgView(
                    imageUrl: preffixIcon!,
                    height: 16,
                    width: 16,
                    isFromAssets: true,
                    svgColor: isFlatButton!
                        ? ColorUtilities.text_900
                        : ColorUtilities.white,
                  )
                : SizedBox(),
            SizedBox(width: preffixIcon != null ? 10 : 0),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    title ?? '',
                    style: buttonSize == ButtonSize.small
                        ? FontStyleUtilities.t3(
                            fontColor: isFlatButton!
                                ? Theme.of(context).primaryColor
                                : ColorUtilities.white,
                            fontWeight: FWT.semiBold,
                          )
                        : FontStyleUtilities.t2(
                            fontColor: isFlatButton!
                                ? Theme.of(context).primaryColor
                                : ColorUtilities.white,
                            fontWeight: FWT.semiBold,
                          ),
                  ),
            SizedBox(width: suffixIcon != null ? 10 : 1),
            suffixIcon != null
                ? CustomSvgView(
                    imageUrl: suffixIcon!,
                    height: 16,
                    width: 16,
                    isFromAssets: true,
                    svgColor: isFlatButton!
                        ? ColorUtilities.text_900
                        : ColorUtilities.white,
                  )
                : SizedBox(),
            secondTitle != null ? Spacer() : SizedBox(),
            secondTitle != null
                ? Text(
                    secondTitle ?? '',
                    style: buttonSize == ButtonSize.small
                        ? FontStyleUtilities.t3(
                            fontColor: isFlatButton!
                                ? ColorUtilities.text_900
                                : ColorUtilities.white,
                            fontWeight: FWT.semiBold,
                          )
                        : FontStyleUtilities.t2(
                            fontColor: isFlatButton!
                                ? ColorUtilities.text_900
                                : ColorUtilities.white,
                            fontWeight: FWT.semiBold,
                          ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
