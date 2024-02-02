import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLOR
const Color primaryColor = Color(0xFFFF9900);
const Color backgroundColor = Color(0xFF171717);
const Color greyColor = Color(0xFFC2C2C2);
const Color whiteColor = Color(0xFFF2F2F2);

// FONT STYLES INITIAL
figmaFontsize(int fontSize) {
  return fontSize * 1.2;
}

TextStyle tsTitlePage = GoogleFonts.poppins(
  color: whiteColor,
  fontWeight: FontWeight.w600,
  fontSize: figmaFontsize(16),
);

TextStyle tsTitleMovie = GoogleFonts.poppins(
  color: greyColor,
  fontWeight: FontWeight.w400,
  fontSize: figmaFontsize(12),
);

TextStyle tsRating = GoogleFonts.poppins(
  color: whiteColor,
  fontWeight: FontWeight.w400,
  fontSize: figmaFontsize(12),
);