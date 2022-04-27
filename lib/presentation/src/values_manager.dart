import 'package:flutter/material.dart';

class Values {
  static const double mobileMaxWidth = 300;
  static const double tabletMaxWidth = 600;
  static const double desktopMaxWidth = 1200;
  static const double zero = 0;


  static const double v8 = 8.0;
  static const double v14 = 14.0;
  static const double v16 = 16.0;
  static const double v18 = 18.0;
  static const double v30 = 30.0;
  static const double v200 = 200.0;
  static const double v300 = 300.0;
  static const double v46 = 46.0;

  static const double o5 = 0.5;
  static const double o4 = 0.4;
  static const double o3 = 0.3;
  static const double o2 = 0.2;
  static const double o1 = 0.1;

  ///opac
}

class Margin with Values {
  static EdgeInsets only({double left = 0.0, double top = 0.0, double right = 0.0, double bottom = 0.0}) =>
      EdgeInsets.only(right: right, left: left, top: top, bottom: bottom);

  static EdgeInsets symmetric({double vertical = 0.0, double horizontal = 0.0}) =>
      EdgeInsets.only(bottom: vertical, top: vertical, left: horizontal, right: horizontal);

  static EdgeInsets all(double n) => EdgeInsets.all(n);

  //

}

class AppSize {


  static const double s0 = 0;
  static const double s1_5 = 1.5;
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s28 = 28.0;
  static const double s40 = 40.0;
  static const double s60 = 60.0;
  static const double s65 = 65.0;
  static const double s100 = 100.0;
  static const double s180 = 180.0;
}

class DurationConstant {
  static const int d300 = 300;
  static const int ds2 = 2;
}

const String EMPTY = "";
const num ZERO = 0;