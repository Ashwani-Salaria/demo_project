import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const Color blackColor = Color(0xFF000000);
  static const Color blackColor12 = Color(0x1F000000);
  static const Color blackColor38 = Color(0x61000000);
  static const Color blackColor45 = Color(0x73000000);
  static const Color blackColor54 = Color(0x8A000000);
  //static const Color blackLightColor = Color(0xFF4A4A4A);
  static const Color blackLightColor = Color(0xFF424141);

  static const Color bluePrimaryColor = Color(0xFF6FAEE6);
  static const Color blueLightChatBgColor = Color(0xFFD9E8F6);
  static const Color blueLightChatSelectColor = Color(0xFFCBE2F6);
  static const Color blueDarkChatBgColor = Color(0xFFBDD8EF);

  //0xFFFFf6ede3
  static const Color blueDarkButtonBgColor = Color(0xFFF2B3990);

  static const Color brownLightColor = Color(0xFF795548);
  static const Color brownDarkColor = Color(0xFF4E342E);

  /// this dandelionColor is for start rating
  static const Color dandelionColor = Color(0xff2D47EE);

  static const Color greenColor = Color(0xff8DC63F);
  static const Color greenLightColor = Color(0xFFCCE1B0);

  static const Color greyInuputBorderColor = Color(0xFF808080);

  static const Color greyScreenBgColor = Color(0xFFF0F0F0);
//424141
  static const Color greyLightColor = Color(0xFFF0F0F0);
  static const Color greyColor300 = Color(0xFFE0E0E0);
  static const Color greyColor350 = Color(0xFFD6D6D6);
  static const Color greyColor400 = Color(0xFFBDBDBD);
  static const Color greyColor = Color(0xFF5f6066);
  static const Color greyColor600 = Color(0xFF757575);

  static const Color orangeColor = Color(0xFFFFfeae3b);
  static const Color orangeLightColor = Color(0xFFFFD740);
  static const Color texColorChat = Color(0xFFFFf6ede3);

  static const Color redColor = Color(0xFFF44336);
  static const Color transparentColor = Colors.transparent;

  static const Color whiteColor = Colors.white;
  static const Color whiteColor10 = Colors.white12;

  static const Color pinkColor = Color(0xffff6347);

  static TextStyle smallParaText(
      {FontWeight fontWeight = FontWeight.w400,
      Color color = Styles.blackLightColor,
      fountSized = 11.0}) {
    return TextStyle(
      color: color,
      fontSize: fountSized,
      fontFamily: 'SourceSansPro',
      fontWeight: fontWeight,
    );
  }

  static TextStyle userNameText = const TextStyle(
    color: Styles.blackColor,
    fontSize: 18,
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w600,
    height: 1,
  );

  static TextStyle textH4 = const TextStyle(
    color: Styles.blackColor,
    fontSize: 18,
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w600,
    height: 1,
  );
}
