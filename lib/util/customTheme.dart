import 'package:flutter/material.dart';

ThemeData customThemeData() {
  const Color primaryColor = Color(0xFF248AEE);
  const Color accentColor = Color(0xFF000000);
  ThemeData initThemeData = new ThemeData.light().copyWith(
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      accentColor: accentColor, //前景色(按钮、文本、覆盖边缘效果等)
      scaffoldBackgroundColor:
          Colors.white, // 作为Scaffold下的Material默认颜色，用于materia应用程序或app内页面的背景色。
      backgroundColor:
          const Color(0xFF202124), //与primaryColor对比的颜色(例如 用作进度条的剩余部分)。
      errorColor: const Color(0xFFB00020), //用于输入验证错误的颜色，例如在TextField中。
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
          bodyText2: TextStyle(color: primaryColor)));
  return initThemeData;
}
