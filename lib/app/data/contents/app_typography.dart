import 'package:analects/app/data/contents/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Extra Light - 400.
  static TextStyle kExtraLight12 =
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.white);
  static TextStyle kExtraLight13 =
      GoogleFonts.inter(fontSize: 13.5.sp, fontWeight: FontWeight.w400);
  static TextStyle kExtraLight15 =
      GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w400);
  static TextStyle kExtraLight16 =
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w400);
  static TextStyle kExtraLight18 =
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w400);

  static TextStyle specialTextStyle = TextStyle(
      color: AppColors.kSecondaryColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold);

  // Light - 500.
  static TextStyle kLight12 =
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w500);
  static TextStyle kLight14 = GoogleFonts.inter(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(0.4));
  static TextStyle kLight15 =
      GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w500);
  static TextStyle kLight16 =
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle kLight18 = GoogleFonts.inter(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white.withOpacity(0.5));

  // Medium - 600.
  static TextStyle kMedium12 =
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600);
  static TextStyle kMedium16 =
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle kMedium18 =
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle kMedium14 =
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600);

  // Bold - 700.
  static TextStyle kBold12 =
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w700);
  static TextStyle kBold14 =
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.white);
  static TextStyle kBold16 =
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700);
  static TextStyle kBold18 =
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w700);
  static TextStyle kBold20 =
      GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w700);
  static TextStyle kBold24 =
      GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w700);
  static TextStyle kBold32 =
      GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.w700);

  // Extra Bold - 800.
  static TextStyle kExtraBold20 =
      GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w800, color: Colors.white);
  static TextStyle kExtraBold32 =
      GoogleFonts.inter(fontSize: 32.sp, fontWeight: FontWeight.w800);
}
