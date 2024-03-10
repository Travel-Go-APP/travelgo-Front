import 'package:countries_world_map/data/maps/countries/south_korea.dart';
import 'package:flutter/material.dart';

/* main.dart */
TextStyle loadingText = const TextStyle(color: Colors.black, fontSize: 20);

/* loginPage.dart */
TextStyle kakaoText = const TextStyle(color: Colors.black, fontSize: 15);

ButtonStyle kakaoButton = ElevatedButton.styleFrom(backgroundColor: Colors.yellow);

/* new_user.dart */
TextStyle welcomeTitle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 50);

TextStyle welcomeText = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

TextStyle nameStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);

TextStyle validatorStyle = const TextStyle(fontSize: 20);

ShapeBorder alertStyle = const RoundedRectangleBorder(side: BorderSide(width: 2, color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(32)));

ButtonStyle addStyle = ElevatedButton.styleFrom(side: const BorderSide(width: 1, color: Colors.black));

Color showButton = Colors.red;
Color hideButton = Colors.transparent;

/* home.dart */
ShapeBorder AppbarButtonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(width: 1, color: Colors.black));

Color AppbarBackColor = Colors.white;

Color AppbarButtonColor = Colors.grey[200]!;

/* Attraction.dart */
SMapSouthKoreaColors mapColor = SMapSouthKoreaColors(
    kr11: Colors.red, // 서울
    kr26: Colors.blue, // 부산
    kr27: Colors.yellow, // 대구
    kr28: Colors.indigo, // 인천
    kr29: Colors.green, // 광주
    kr30: Colors.green, // 대전
    kr31: Colors.black, // 울산
    kr41: Colors.purple, // 경기도
    kr42: Colors.brown, // 강원
    kr43: Colors.pink, // 충청북도
    kr44: Colors.deepPurple, // 충청남도
    kr45: Colors.red, // 전라북도
    kr46: Colors.orange, // 전라남도
    kr47: Colors.blue, // 경상북도
    kr48: Colors.indigo, // 경상남도
    kr49: Colors.orange, // 제주
    kr50: Colors.green, // 세종
    );
