import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sezinsoft_demo/core/utilities/color_utils.dart';
import '../../../size_config.dart';
import '../../core/utilities/font_style_utils.dart';
import 'custom_svg_view.dart';

typedef OnChangeValue = void Function(String);

/// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? icon;
  final Widget? suffixIcon;
  final String? hint;
  final String? text;
  final bool? readOnly;

  final bool? obsecure;
  final double? height;
  final double? width;
  int? maxLines = 1;

  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  List<TextInputFormatter>? inputFormatters;
  TextCapitalization textCapitalization;

  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final OnChangeValue? onChange;

  final decoration;

  CustomTextField(
      {Key? key,
      this.controller,
      this.icon,
      this.hint,
      this.obsecure = false,
      this.keyboardType,
      this.height,
      this.width,
      this.onTap,
      this.onChange,
      this.inputFormatters,
      this.suffixIcon,
      this.onSaved,
      this.validator,
      this.decoration,
      this.readOnly = false,
      this.textCapitalization = TextCapitalization.none,
      this.text,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: width ?? screenSize.width,
      decoration: BoxDecoration(
        color: ColorUtilities.light_700,
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*icon != null
              ? CustomSvgView(
                  imageUrl: icon,
                  isFromAssets: true,
                  height: 16,
                  width: 16,
                  svgColor: Theme.of(context).primaryColor)
              : SizedBox(),
          SizedBox(width: icon != null ? 10 : 0),*/
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20),
                  vertical: getProportionateScreenHeight(4)),
              child: TextFormField(
                textCapitalization: textCapitalization,
                onSaved: onSaved,
                readOnly: readOnly!,
                maxLines: maxLines,
                validator: validator,
                controller: controller,
                obscureText: obsecure!,
                keyboardType: keyboardType ?? TextInputType.text,
                onTap: onTap ?? () {},
                onChanged: onChange ?? (String value) {},
                inputFormatters: inputFormatters ?? [],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.1),
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(15)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(15)),
                  ),
                  hintText: hint,
                  hintStyle: FontStyleUtilities.t1(
                    fontColor: ColorUtilities.dark_100,
                    fontWeight: FWT.regular,
                  ),
                ),
                style: FontStyleUtilities.t1(
                  fontColor: ColorUtilities.dark_900,
                  fontWeight: FWT.regular,
                ),
              ),
            ),
          ),
          SizedBox(width: suffixIcon != null ? 10 : 0),
          suffixIcon ?? SizedBox(),
        ],
      ),
    );
  }
}
