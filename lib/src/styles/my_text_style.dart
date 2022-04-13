import 'package:flutter/material.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter_siap_nikah/src/styles/my_font_weight.dart';

class MyTextStyle {
  static MyTextStyleFontWeight get h1 =>
      MyTextStyleFontWeight.custom(fontSize: 24.0);

  static MyTextStyleFontWeight get h2 =>
      MyTextStyleFontWeight.custom(fontSize: 22.0);

  static MyTextStyleFontWeight get h3 =>
      MyTextStyleFontWeight.custom(fontSize: 20.0);

  static MyTextStyleFontWeight get h4 =>
      MyTextStyleFontWeight.custom(fontSize: 18.0);

  static MyTextStyleFontWeight get h5 =>
      MyTextStyleFontWeight.custom(fontSize: 16.0);

  static MyTextStyleFontWeight get h6 =>
      MyTextStyleFontWeight.custom(fontSize: 14.0);

  static MyTextStyleFontWeight get h7 =>
      MyTextStyleFontWeight.custom(fontSize: 12.0);

  static TextStyle get contentTitle => MyTextStyle.h4.bold;

  static TextStyle get contentDescription =>
      MyTextStyle.h7.normal.copyWith(color: MyColors.text);

  static TextStyle get sectionTitle => MyTextStyle.h3.bold;

  static TextStyle get appBarTitle =>
      MyTextStyle.h3.normal.copyWith(color: MyColors.black);

  static TextStyle get bottomSheetTitle =>
      MyTextStyle.h2.bold.copyWith(color: MyColors.backdrop);

  static TextStyle get sessionTitle =>
      MyTextStyle.h5.semiBold.copyWith(color: MyColors.backdrop);

  static TextStyle get milestoneTitle => TextStyle(
      fontSize: 32,
      fontWeight: MyFontWeight.ultraBold,
      color: MyColors.white);

  static TextStyle get buttonTitle =>
      h4.normal.copyWith(color: MyColors.backdrop);

  static TextStyle get smallButtonTitle =>
      h6.semiBold.copyWith(color: MyColors.primary);
}

// ignore: must_be_immutable
class MyTextStyleFontWeight extends Palette {
  late double? fontSize;

  MyTextStyleFontWeight();

  MyTextStyleFontWeight.custom({this.fontSize});

  TextStyle get _thin => TextStyle(
        fontWeight: MyFontWeight.thin,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _extraLight => TextStyle(
        fontWeight: MyFontWeight.extraLight,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _light => TextStyle(
        fontWeight: MyFontWeight.light,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _normal => TextStyle(
        fontWeight: MyFontWeight.normal,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _medium => TextStyle(
        fontWeight: MyFontWeight.medium,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _semiBold => TextStyle(
        fontWeight: MyFontWeight.semiBold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _bold => TextStyle(
        fontWeight: MyFontWeight.bold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _extraBold => TextStyle(
        fontWeight: MyFontWeight.extraBold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  TextStyle get _ultraBold => TextStyle(
        fontWeight: MyFontWeight.ultraBold,
        color: Colors.black,
        fontSize: this.fontSize,
      );

  @override
  TextStyle get thin => _thin;

  @override
  TextStyle get extraLight => _extraLight;

  @override
  TextStyle get light => _light;

  @override
  TextStyle get normal => _normal;

  @override
  TextStyle get medium => _medium;

  @override
  TextStyle get semiBold => _semiBold;

  @override
  TextStyle get bold => _bold;

  @override
  TextStyle get extraBold => _extraBold;

  @override
  TextStyle get ultraBold => _ultraBold;

//  @override
//  TextStyle tint(Color color) => TextStyle(color: color);
}

abstract class Palette extends TextStyle {
  Palette();

  TextStyle get thin;

  TextStyle get extraLight;

  TextStyle get light;

  TextStyle get normal;

  TextStyle get medium;

  TextStyle get semiBold;

  TextStyle get bold;

  TextStyle get extraBold;

  TextStyle get ultraBold;
}
