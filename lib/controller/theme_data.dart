import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static final MaterialColor primarySwatch = Colors.blue;
  static final Color primaryColor =
      Colors.blueAccent[400]!; //Color(0xff26a67d);
  static final Color softPrimaryColor = Colors.lightBlue[100]!;
  static final Color primaryColor50 = Colors.indigo[100]!; //Color(0xff7d9db0);
  static final Color bgColor =
      Colors.grey[100]!; //Color(0xffeff1f5); //Color(0xffFAFCFB);
  static final Color bgColorDark = Colors.grey[200]!; //Color(0xffc5fadf);
  static final Color accentColor = Colors.blueGrey[900]!; //Color(0xff86cdb2);
  static final Color dangerColor = Colors.redAccent; //Color(0xffD91C53);
  static final Color textColorDark = Colors.blueGrey[900]!; //Color(0xff080c0d);
  static final Color textColorLight = Colors.blueGrey[50]!; //Color(0xfff8f8f8);
  static final Color highlightTextColorDark = Color(0xffa6bab2);
  static final Color highlightTextColorLight = Color(0xff60625b);

  static final TextStyle defaultText = GoogleFonts.montserrat(
    color: textColorDark,
  );
  static final TextStyle lightText = GoogleFonts.montserrat(
    color: textColorLight,
  );
  static final TextStyle smallText = GoogleFonts.montserrat(
    fontSize: 11,
    color: textColorDark,
  );
  static final TextStyle smallLightText = GoogleFonts.montserrat(
    fontSize: 11,
    color: textColorLight,
  );
  static final TextStyle smallPrimaryText = GoogleFonts.montserrat(
    fontSize: 11,
    color: primaryColor,
  );
  static final TextStyle defaultHighlightText = GoogleFonts.montserrat(
    color: highlightTextColorDark,
  );
  static final TextStyle h3 = GoogleFonts.montserrat(
    color: textColorDark,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle h4 = GoogleFonts.montserrat(
    color: textColorDark,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
  static final TextStyle h3Light = GoogleFonts.montserrat(
    color: textColorLight,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );
  static final TextStyle h3Primary = GoogleFonts.montserrat(
    color: primaryColor,
    fontWeight: FontWeight.w900,
    fontSize: 20,
  );
  static final TextStyle h3Accent = GoogleFonts.montserrat(
    color: accentColor,
    fontWeight: FontWeight.w900,
    fontSize: 20,
  );
}
