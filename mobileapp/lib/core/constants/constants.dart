import 'package:flutter/material.dart';

// Rouge
const Color kPrimaryRed = Color.fromRGBO(225, 56, 56, 1);
const Color KSecondaryRed = Color(0x66E13838);

// Blanc
const Color kPrimaryWhite = Color(0xFFFFFFFF);
const Color kSecondaryWhite = Color(0xFFF5F5F5);
const Color kLightGrayWhite = Color(0xFFEEEEEE);

// Jaune
const Color kPrimaryYellow = Color(0xFFF5CB58);

// Gris
const Color kDarkGray = Color(0xFF504E4E);
const Color kMediumGray = Color(0xFF686868);
const Color kRegularGray = Color(0xFFBCBCBC);
const Color kLightGray = Color(0xFFCCCCCC);
const Color kWhiteGray = Color.fromARGB(255, 225, 224, 224);

// Noir
const Color kPrimaryBlack = Color(0xFF1A1A1A);
const Color kPrimaryDark = Color(0xFF282525);
const Color kSecondaryDark = Color(0xFF363333);
const Color kPrimaryBlur = Color(0x4D000000); // 30% opacity

// Vert
const Color kPrimaryGreen = Color(0xFF34EB4F);
const Color kSecondaryGreen = Color(0xFF47CF5B);
const Color kLightGreen = Color(0x666ACB5D);

const double kDefaultPadding = 0.035;

const int kRequiredPoints30 = 250;
const int kRequiredPoints60 = 750;
const int kRequiredPoints100 = 1000;
const List<String> predefinedCodes = [
  'PROMO',
  'PIZZA',
  'FRUITS',
  'LEGUME',
  'VIANDE',
  'BOISSON',
  'DESSERT',
  'FROMAGE',
];

const double priceCoupon30 = 1000;
const double priceCoupon60 = 1000;
const double priceCoupon100 = 1000;

const String descriptionCoupon = "Bénificie d'une livraison gratuite";
final GlobalKey verticalListKey = GlobalKey();