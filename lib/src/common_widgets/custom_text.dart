import 'package:flutter/material.dart';
import 'package:super_to_do/src/constants/app_sizes.dart';

class CustomText extends Text {
  CustomText._(
    BuildContext context,
    String text, {
    Key? key,
    double? size,
    color,
    weight,
    bool underline = false,
    strutStyle,
    textAlign,
    textDirection,
    locale,
    softWrap,
    overflow,
    textScaleFactor,
    maxLines,
    semanticsLabel,
    textWidthBasis,
    height,
    textHeightBehavior,
  }) : super(
          key: key,
          text,
          style: TextStyle(
            color: color,
            height: height,
            fontSize: size,
            fontWeight: weight,
            decoration: underline ? TextDecoration.underline : null,
          ),
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );

  CustomText.f28(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    bool? underline,
    TextAlign? textAlign,
    double? height,
    int? maxLines,
  }) : this._(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.p32,
          height: height,
          color: color ?? Theme.of(context).primaryColor,
          weight: weight ?? FontWeight.bold,
          textAlign: textAlign,
        );

  CustomText.f20(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    double? height,
    int? maxLines,
    dynamic overflow,
  }) : this._(
          context,
          text,
          key: key,
          size: Sizes.p20,
          color: color ?? Theme.of(context).primaryColor,
          weight: weight ?? FontWeight.bold,
          textAlign: textAlign,
          height: height,
          maxLines: maxLines,
          overflow: overflow,
        );

  CustomText.f18(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    double? height,
    bool underline = false,
    dynamic overflow,
    int? maxLines,
  }) : this._(
          context,
          text,
          key: key,
          size: Sizes.p18,
          color: color ?? Theme.of(context).primaryColor,
          weight: weight,
          height: height,
          textAlign: textAlign,
          underline: underline,
          maxLines: maxLines,
          overflow: overflow,
        );

  CustomText.f16(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    double? height,
    bool underline = false,
    dynamic overflow,
    int? maxLines,
  }) : this._(
          context,
          text,
          key: key,
          size: Sizes.p16,
          color: color ?? Theme.of(context).primaryColor,
          weight: weight,
          height: height,
          textAlign: textAlign,
          underline: underline,
          maxLines: maxLines,
          overflow: overflow,
        );

  CustomText.f14(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    double? height,
    dynamic overflow,
    int? maxLines,
  }) : this._(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.p14,
          height: height,
          color: color ?? Theme.of(context).primaryColor,
          weight: weight,
          overflow: overflow,
          textAlign: textAlign,
        );

  CustomText.f12(
    BuildContext context,
    String text, {
    Key? key,
    Color? color,
    FontWeight? weight,
    TextAlign? textAlign,
    dynamic overflow,
    double? height,
    int? maxLines,
  }) : this._(
          context,
          text,
          key: key,
          maxLines: maxLines,
          size: Sizes.p12,
          height: height,
          overflow: overflow,
          color: color ?? Theme.of(context).primaryColor,
          weight: weight,
          textAlign: textAlign,
        );
}
