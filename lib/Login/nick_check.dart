
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> checkNick(String nickName) async {

    await dotenv.load(fileName: 'assets/env/.env');
    var urlPath = dotenv.env['SERVER_URL']!;
    // var headers = {"accecpt": '*/*',};
    var headers = {"accecpt": '*/*', 'Content-Type': 'application/json'};
    var bodys = jsonEncode({
      "kakaoId": "gfdhsfgaszxcvczx",
      "email": "asdfdsgvxvzxcv",
      "nickname": nickName});

    // final url = Uri.parse('$urlPath/user/check-nickname?nickname=$nickName');
    // final url = Uri.parse('$urlPath/user/kakao_check?kakaoId=$nickName');
    final url = Uri.parse('$urlPath/user/signup');
    // http.Response response = await http.post( url, headers: headers);
    // http.Response response = await http.post( url, headers: headers, body: bodys);
      // body: queryJson;
    // print("body is $bodys");
    http.Response response = await http.post( url, headers: headers, body: bodys);
    print("response is ${response.statusCode}");
  }