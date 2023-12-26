import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/Login/UserModel.dart';
import 'package:travel_go/Login/kakao_login.dart';
import 'package:travel_go/loginPage.dart';

class logined_Page extends StatefulWidget {
  const logined_Page({super.key});

  @override
  State<logined_Page> createState() => _logined_PageState();
}

class _logined_PageState extends State<logined_Page> {
  var login_model = UserModel(Kakao_Login()); // 카카오 로그인

  @override
  void initState() {
    refresh_date(); // 유저 정보 갱신
    setState(() {});
    super.initState();
  }

  Future refresh_date() async {
    // 유저 정보 갱신
    await login_model.Refresh_user();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${login_model.user?.kakaoAccount?.profile?.nickname}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await login_model.logout();
                  setState(() {
                    Get.off(() => const login_Page());
                  });
                },
                child: const Text("카카오 로그아웃"))
          ],
        ),
      ),
    );
  }
}
