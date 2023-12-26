import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/Login/UserModel.dart';
import 'package:travel_go/Login/kakao_login.dart';
import 'package:travel_go/loginedPage.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Travel Go"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text('로그인 방식을 선택해주세요'),
            ElevatedButton(
                onPressed: () async {
                  await login_model.login();
                  setState(() {
                    if (login_model.isLogined) {
                      Get.off(() => const logined_Page());
                    }
                  });
                },
                child: const Text("카카오 로그인"))
          ],
        ),
      ),
    );
  }
}
