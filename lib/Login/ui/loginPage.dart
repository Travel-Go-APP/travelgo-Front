import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:travel_go/Login/function/UserModel.dart';
import 'package:travel_go/Login/function/kakao_login.dart';
import 'package:travel_go/Home/ui/home.dart';
import 'package:travel_go/style.dart';
import 'package:xtyle/xtyle.dart';

class login_Page extends StatefulWidget {
  const login_Page({super.key});

  @override
  State<login_Page> createState() => _login_PageState();
}

class _login_PageState extends State<login_Page> {
  var login_model = UserModel(Kakao_Login()); // 카카오 로그인

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/Logo.png',
              scale: 3,
            ),
            ElevatedButton(
                style: kakaoButton,
                onPressed: () async {
                  print("값은 ${await KakaoSdk.origin}");
                  await login_model.login();
                  setState(() {
                    if (login_model.isLogined) {
                      Get.off(() => const logined_Page());
                    }
                  });
                },
                child: XtyleText(
                  "카카오 로그인",
                  style: kakaoText,
                ))
          ],
        ),
      ),
    );
  }
}
