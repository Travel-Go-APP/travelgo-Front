import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:travel_go/Login/function/UserModel.dart';
import 'package:travel_go/Login/function/kakao_login.dart';
import 'package:travel_go/Login/ui/loginPage.dart';
import 'package:travel_go/Login/ui/new_user.dart';
import 'package:travel_go/style.dart';
import 'package:xtyle/xtyle.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env/.env');
  WidgetsFlutterBinding.ensureInitialized(); // 위젯 바인딩
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 상태바 색상
  await Hive.initFlutter(); // 데이터베이스 초기화
  await Hive.openBox<int>('steps'); // 데이터베이스 로딩
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVEAPPKEY']); // 카카오 초기화
  await NaverMapSdk.instance.initialize(clientId: dotenv.env['NAVERMAP_CLIENTID']); // 네이버맵 초기화
  Xtyle.init(
      configuration: XtyleConfig(mapper: {
    XtyleRegExp.korean: 'GmarketSans', // 한글 폰트
    XtyleRegExp.digit: 'GmarketSans', // 숫자 폰트
  }, defaultFontFamily: 'Inter' // 그 외 폰트 (영문)
          ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var loginModel = UserModel(Kakao_Login()); // 카카오 로그인
  String userLoad = "";

  @override
  void initState() {
    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        userLoad = "초기 설정중..";
      });
    });
    Timer(const Duration(milliseconds: 2000), () async {
      // 로딩화면을 보여주기 위한 딜레이 (Splash Screen)
      await kakaoChech(); // 카카오 로그인 토큰 검사
      loginModel.isLogined // 로그인 이력이 있을시
          // ? Get.off(() => const logined_Page()) // 메인페이지
          ? Get.off(() => const NewUser()) // 테스트를 위한 유저 생성 페이지 이동
          : Get.off(() => const login_Page()); // 로그인페이지
      /* Get.to : 새로운 화면으로 이동
         Get.off : 새로운 화면으로 이동할때, 이전 화면을 없앤다. */
    });
    super.initState();
  }

  Future kakaoChech() async {
    userLoad = "로그인 확인중...";
    if (await AuthApi.instance.hasToken()) {
      // SDK에 기존에 발급받은 토큰이 있는지 확인
      await loginModel.checkToken(); // 토큰 유효성 검사
      setState(() {});
    } else {
      print('발급된 토큰 없음');
      // try {
      //   await UserApi.instance.loginWithKakaoAccount();
      //   print("발급된 토큰이 없어서 재로그인 후 성공");
      // } catch (e) {
      //   print("재로그인을 시도했지만 실패했습니다.");
      // }
    }
  }

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
            XtyleText(userLoad, style: loadingText), // 값이 변하기에 const를 사용하지 않음
          ],
        ),
      ),
    );
  }
}
