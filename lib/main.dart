import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:travel_go/Login/UserModel.dart';
import 'package:travel_go/Login/kakao_login.dart';
import 'package:travel_go/loginPage.dart';
import 'package:travel_go/loginedPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 위젯 바인딩
  KakaoSdk.init(nativeAppKey: '2e3648104cc8e6f4710f9280358233fe'); // 카카오 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var login_model = UserModel(Kakao_Login()); // 카카오 로그인
  String user_load = "안녕";

  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () async {
      // 로딩화면을 보여주기 위한 딜레이 (Splash Screen)
      await kakao_check(); // 카카오 로그인 토큰 검사
      login_model.isLogined // 로그인 이력이 있을시
          ? Get.off(() => const logined_Page()) // 메인페이지
          : Get.off(() => const login_Page()); // 로그인페이지
      /* Get.to : 새로운 화면으로 이동
         Get.off : 새로운 화면으로 이동할때, 이전 화면을 없앤다. */
    });
    super.initState();
  }

  Future kakao_check() async {
    if (await AuthApi.instance.hasToken()) {
      // SDK에 기존에 발급받은 토큰이 있는지 확인
      user_load = "로그인 확인중...";
      await login_model.checkToken(); // 토큰 유효성 검사
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Travel Go'),
            Text(user_load), // 값이 변하기에 const를 사용하지 않음
          ],
        ),
      ),
    );
  }
}
