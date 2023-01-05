import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = AppColors.primaryRed;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    double width = 100.w;

    final bool useMobileLayout = width < 600;

    return ThemeData(
        fontFamily: 'Montserrat',
        canvasColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        iconTheme: IconThemeData(size: 6.w),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            systemNavigationBarColor: Color(0xFF000000),
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 6.w),
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            elevation: 0.0,
            minimumSize: Size(double.infinity, 6.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.5.w),
            ),
            textStyle: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.blue,
            elevation: 0.0,
            side: const BorderSide(color: AppColors.blue, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.w),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 8.5.w, vertical: !useMobileLayout ? 1.h : 0),
            textStyle: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2),
          ),
        ),
        chipTheme: const ChipThemeData(
          selectedColor: primaryColor,
          backgroundColor: AppColors.lightRed,
          padding: EdgeInsets.all(5.0),
          brightness: Brightness.light,
          disabledColor: Colors.grey,
          secondarySelectedColor: AppColors.lightRed,
          secondaryLabelStyle: TextStyle(
            color: AppColors.bluishBlack,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(fontSize: 12.sp),
            labelStyle: TextStyle(fontSize: 12.sp),
            contentPadding:
                EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22.w),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22.w),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            )),
        textTheme: TextTheme(
          subtitle1: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15),
          subtitle2: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
          ),
          bodyText1: TextStyle(
              fontSize: 17.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
          bodyText2: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.25),
          button: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25),
          caption: TextStyle(
              fontSize: 10.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4),
          overline: TextStyle(
              fontSize: 8.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
              //<-- SEE HERE
              side: const BorderSide(
                color: AppColors.darkGrey,
              ),
              borderRadius: BorderRadius.circular(25.0)),
          color: Colors.white,
          elevation: 3,
        ));
  }
}
