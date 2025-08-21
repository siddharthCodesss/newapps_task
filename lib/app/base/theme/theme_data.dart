//To set theme for light mode
import 'package:flutter/material.dart';
import 'package:newapps_task/app/base/constants/size_constants.dart';

import '../constants/color_constants.dart';

ThemeData lightThemeData() => ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 10.0,
    foregroundColor: Colors.white,
    backgroundColor: ColorConstants.primaryColor,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    textStyle: lightPopupMenuTextStyle(),
  ),
  radioTheme: RadioThemeData(
      fillColor:
      MaterialStateProperty.all<Color>(ColorConstants.secondaryColor)),
  checkboxTheme: CheckboxThemeData(
      fillColor:
      MaterialStateProperty.all<Color>(ColorConstants.secondaryColor)),
  bottomSheetTheme:
  const BottomSheetThemeData(backgroundColor: Colors.white),
  dialogTheme: const DialogTheme(backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: ColorConstants.primaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
);

//To set theme for dark mode
ThemeData darkThemeData() => ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 10.0,
      foregroundColor: Colors.white,
      backgroundColor: ColorConstants.fabButtonColor),
  popupMenuTheme: PopupMenuThemeData(
    color: ColorConstants.darkSecondaryColor,
    textStyle: darkPopupMenuTextStyle(),
  ),
  radioTheme: RadioThemeData(
      fillColor:
      MaterialStateProperty.all<Color>(ColorConstants.secondaryColor)),
  checkboxTheme: CheckboxThemeData(
      fillColor:
      MaterialStateProperty.all<Color>(ColorConstants.secondaryColor)),
  bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorConstants.darkSecondaryColor),
  dialogTheme:
  const DialogTheme(backgroundColor: ColorConstants.darkSecondaryColor),
  scaffoldBackgroundColor: ColorConstants.darkPrimaryColor,
  brightness: Brightness.dark,
  primaryColor: ColorConstants.darkPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
);

//Popupmenu style for light mode
TextStyle lightPopupMenuTextStyle() => TextStyle(
  color: ColorConstants.primaryTextColor,
  fontWeight: SizeConstants.fontWeightRegular,
  fontSize: SizeConstants.size14,
);

//Popupmenu style for dark mode
TextStyle darkPopupMenuTextStyle() => TextStyle(
  color: Colors.white,
  fontWeight: SizeConstants.fontWeightRegular,
  fontSize: SizeConstants.size14,
);
