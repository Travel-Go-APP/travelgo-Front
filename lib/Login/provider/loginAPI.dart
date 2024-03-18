import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginAPI{
  late final http.Client httpClient;
  LoginAPI({required this.httpClient});

  loadBaseURL() async {
    return dotenv.env['SERVER_URL']!;
  }
  
  checkNick(String nickName) async {
    var urlPath = loadBaseURL;
    final url = Uri.parse('$urlPath/user/check_nickname?nickname=$nickName');
    var headers = {"accecpt": '*/*',};

    try {
      var response = await httpClient.post(url, headers: headers);
      if (response.statusCode == 200) {
        
        return true;
      } else{
        return false;
      }
        
    } catch (_) {}
  }
  signUp(String nickName) async {
    var urlPath = loadBaseURL;
    final url = Uri.parse('$urlPath/user/signup');
    var headers = {"accecpt": '*/*', 'Content-Type': 'application/json'};
    var bodys = jsonEncode({
      "kakaoId": "gfdhsfgaszxcvczx",
      "email": "asdfdsgvxvzxcv",
      "nickname": nickName});
    
    try {
      var response = await httpClient.post( url, headers: headers, body: bodys);
      if (response.statusCode == 200) {
        
        return true;
      } else{

        return false;
      }
        
    } catch (_) {}
    
  }

}
