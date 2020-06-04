import 'package:flutter/material.dart';

//Doubles
const double radius = 25;

//Colors
const Color primaryColor = Color(0xff4B95CD);
const Color greyColor = Color(0xff616161);


//Durations
const Duration duration200 = Duration(milliseconds: 200);
const Duration duration300 = Duration(milliseconds: 300);
const Duration duration400 = Duration(milliseconds: 400);
const Duration duration500 = Duration(milliseconds: 500);
const Duration duration600 = Duration(milliseconds: 600);
const Duration duration700 = Duration(milliseconds: 700);
const Duration duration800 = Duration(milliseconds: 800);

//Curves
const Curve fastOutSlowIn = Curves.fastOutSlowIn;

//Input Decorations
final borderSide = BorderSide(width: 0, color: Colors.transparent);
InputDecoration inputDecoration = InputDecoration(
  fillColor: Colors.grey[300],
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 20),
  errorStyle: poppinsMedium,
  labelStyle: poppinsMedium,
  focusColor: Colors.white,
  counterText: "",
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: borderSide,
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: borderSide,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: borderSide,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: borderSide,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: borderSide,
  ),
);


//Font Families
//..Poppins

const poppins = 'Poppins';

const TextStyle poppinsRegular = TextStyle(
  fontFamily: poppins,
  fontWeight: FontWeight.w400,
);

const TextStyle poppinsMedium = TextStyle(
  fontFamily: poppins,
  fontWeight: FontWeight.w600,
);

const TextStyle poppinsLight = TextStyle(
  fontFamily: poppins,
  fontWeight: FontWeight.w300,
);

const TextStyle poppinsBold = TextStyle(
  fontFamily: poppins,
  fontWeight: FontWeight.w700,
);
