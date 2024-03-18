import 'package:flutter/material.dart';
import 'package:travel_go/Login/provider/loginAPI.dart';

class loginRepo{
  final LoginAPI loginapi;
  loginRepo({required this.loginapi});

  checkNick(String nickName){
    return loginapi.checkNick(nickName);
  }

  signUp(String nickName){
    return loginapi.signUp(nickName);
  }
}