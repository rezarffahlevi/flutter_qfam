import 'package:flutter/material.dart';
import 'package:flutter_siap_nikah/src/commons/app_settings.dart';
import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter_siap_nikah/src/styles/my_font_weight.dart';
import 'package:flutter_siap_nikah/src/styles/my_text_style.dart';
import 'package:getwidget/getwidget.dart';

Widget sectionWidget(text, {child, showAll = true, onTapAll}) {
  return InkWell(
    onTap: onTapAll,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(text, style: MyTextStyle.contentTitle),
              showAll
                  ? Row(
                      children: [
                        Text(
                          "Lihat semua",
                          style: MyTextStyle.sessionTitle
                              .copyWith(color: MyColors.primary),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: MyColors.primary,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        Spaces.smallVertical(),
        child,
        Spaces.normalVertical(),
      ],
    ),
  );
}

Widget appBar({onTap: Function, icon: Icons.notifications}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    height: 60.0,
    color: MyColors.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Container(
              padding: const EdgeInsets.all(5.0),
              child: GFAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                size: 20,
                backgroundColor: MyColors.background,
              )),
          onTap: () {},
        ),
        Spaces.normalHorizontal(),
        Text(
          AppSettings.name,
          style: MyTextStyle.appBarTitle.copyWith(
              color: MyColors.textReverse, fontWeight: MyFontWeight.bold),
        ),
        Spaces.normalHorizontal(),
        onTap == null
            ? Container()
            : InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    icon,
                    color: MyColors.textReverse,
                    size: 24,
                  ),
                ),
                onTap: onTap,
              ),
      ],
    ),
  );
}
