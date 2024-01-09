import 'package:flutter/material.dart';

/* main.dart */
TextStyle loadingText = const TextStyle(color: Colors.black, fontSize: 20);

/* loginPage.dart */
TextStyle kakaoText = const TextStyle(color: Colors.black, fontSize: 15);

ButtonStyle kakaoButton =
    ElevatedButton.styleFrom(backgroundColor: Colors.yellow);

/* new_user.dart */
TextStyle welcomeTitle =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 50);

TextStyle welcomeText =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

TextStyle nameStyle = const TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);

TextStyle validatorStyle = const TextStyle(fontSize: 20);

ShapeBorder alertStyle = const RoundedRectangleBorder(
    side: BorderSide(width: 2, color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(32)));

ButtonStyle addStyle = ElevatedButton.styleFrom(
    side: const BorderSide(width: 1, color: Colors.black));
