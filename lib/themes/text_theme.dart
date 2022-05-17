import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  headline4: GoogleFonts.lato(
    fontSize: 34,
    fontWeight: FontWeight.w500,
  ),
  headline5: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.w500),
  headline6: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w500),
  bodyText1: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
  bodyText2: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500),
  subtitle2: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500),
  caption: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w500),
  button: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w500),
).apply(
  displayColor: const Color(0xFF1E272E),
  bodyColor: const Color(0xFF1E272E),
);
