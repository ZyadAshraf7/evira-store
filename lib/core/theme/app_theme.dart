import 'package:flutter/material.dart';

class AppTheme {


  const AppTheme._();

  static const Color primary500 = Color(0xff101010);
  static const Color primary400 = Color(0xff404040);
  static const Color primary300 = Color(0xff707070);
  static const Color primary200 = Color(0xff9F9F9F);
  static const Color primary100 = Color(0xffE7E7E7);

  static const Color secondary500 = Color(0xff797979);
  static const Color secondary400 = Color(0xff949494);
  static const Color secondary300 = Color(0xffAFAFAF);
  static const Color secondary200 = Color(0xffC9C9C9);
  static const Color secondary100 = Color(0xffF2F2F2);

  static const Color grey900 = Color(0xff212121);
  static const Color grey800 = Color(0xff424242);
  static const Color grey700 = Color(0xff616161);
  static const Color grey600 = Color(0xff757575);
  static const Color grey500 = Color(0xff9E9E9E);
  static const Color grey400 = Color(0xffBDBDBD);
  static const Color grey300 = Color(0xffE0E0E0);
  static const Color grey200 = Color(0xffEEEEEE);
  static const Color grey100 = Color(0xffF5F5F5);
  static const Color grey50 = Color(0xffFAFAFA);

  static const Color error = Color(0xffF75555);

  static final appTheme = ThemeData(
      fontFamily: 'Urbanist',
      scaffoldBackgroundColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: grey900),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: primary500,
        ),
        titleTextStyle: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: grey900),
      ),
      primaryColor: primary500,
      textTheme: const TextTheme(
        // headline1
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        // headline2
        displayMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        // headline3
        displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        // headline4
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // headline5
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        // headline6
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary500),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: grey100),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error),
        ),
        fillColor: grey100,
        filled: true,
        hintStyle: bodyMediumRegular.copyWith(color: grey500),
      )


  );
  static const TextStyle bodyXLargeBold = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.bold,);
  static const TextStyle bodyXLargeSemiBold = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w600,);
  static const TextStyle bodyXLargeMedium = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w500,);
  static const TextStyle bodyXLargeRegular = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.w400,);

  static const TextStyle bodyLargeBold = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.bold,);
  static const TextStyle bodyLargeSemiBold = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w600,);
  static const TextStyle bodyLargeMedium = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w500,);
  static const TextStyle bodyLargeRegular = TextStyle(
    fontSize: 16.0, fontWeight: FontWeight.w400,);

  static const TextStyle bodyMediumBold = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.bold,);
  static const TextStyle bodyMediumSemiBold = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w600,);
  static const TextStyle bodyMediumMedium = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w500,);
  static const TextStyle bodyMediumRegular = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w400,);

  static const TextStyle bodySmallBold = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.bold,);
  static const TextStyle bodySmallSemiBold = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w600,);
  static const TextStyle bodySmallMedium = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w500,);
  static const TextStyle bodySmallRegular = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.w400,);

  static const TextStyle bodyXSmallBold = TextStyle(
    fontSize: 10.0, fontWeight: FontWeight.bold,);
  static const TextStyle bodyXSmallSemiBold = TextStyle(
    fontSize: 10.0, fontWeight: FontWeight.w600,);
  static const TextStyle bodyXSmallMedium = TextStyle(
    fontSize: 10.0, fontWeight: FontWeight.w500,);
  static const TextStyle bodyXSmallRegular = TextStyle(
    fontSize: 10.0, fontWeight: FontWeight.w400,);

  static Gradient blackGradient = const LinearGradient(
    colors: [
      Color(0xff313130),
      Color(0xff101010),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}