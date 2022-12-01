import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/utilities/asset_utils.dart';

/// THIS IS THE CLASS FOR SHOW IMAGES...
/// ignore: must_be_immutable
class CustomImageView extends StatelessWidget {
  final String? imageUrl;
  final bool? isFromAssets;
  final bool? isFromFile;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final BorderRadius? radius;

  const CustomImageView(
      {Key? key,
      this.imageUrl,
      this.isFromAssets = true,
      this.isFromFile = false,
      this.height,
      this.width,
      this.fit,
      this.radius,
      this.color})
      : assert(imageUrl != "" && imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius ?? BorderRadius.circular(0),
        // color: ColorUtilities.primary_050,
      ),
      child: ClipRRect(
          borderRadius: radius ?? BorderRadius.circular(0),
          child: isFromAssets!
              ? Image.asset(
                  imageUrl!,
                  height: height ?? null,
                  width: width ?? null,
                  fit: fit ?? BoxFit.contain,
                  errorBuilder:
                      (BuildContext context, Object obj, StackTrace? st) =>
                          Image.asset(
                    AssetUtilities.applicationlogo,
                    height: height ?? null,
                    width: width ?? null,
                    fit: fit ?? BoxFit.contain,
                  ),
                )
              : isFromFile!
                  ? Image.file(File(imageUrl!),
                      height: height ?? null,
                      width: width ?? null,
                      fit: fit ?? BoxFit.contain,
                      errorBuilder:
                          (BuildContext context, Object obj, StackTrace? st) =>
                              Image.asset(
                                AssetUtilities.applicationlogo,
                                height: height ?? null,
                                width: width ?? null,
                                fit: fit ?? BoxFit.contain,
                              ))
                  : CachedNetworkImage(
                      height: height ?? null,
                      width: width ?? null,
                      imageUrl: imageUrl!,
                      color: color ?? null,
                      fit: fit ?? BoxFit.contain,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Container(
                            height: 48,
                            width: 48,
                            child: new Image.asset('assets/icons/loading.gif')),
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    )),
    );
  }
}
