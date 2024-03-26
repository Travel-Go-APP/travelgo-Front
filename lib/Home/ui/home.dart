import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:travel_go/Attraction/ui/Attraction.dart';
import 'package:travel_go/Home/function/Geolocation.dart';
import 'package:travel_go/Home/function/db_steps.dart';
import 'package:travel_go/Rank/ui/Rank.dart';
import 'package:travel_go/collection/ui/BottomNav_item.dart';
import 'package:travel_go/collection/ui/collection.dart';
import 'package:travel_go/package_Info.dart';
import 'package:travel_go/Home/ui/daily_mission.dart';
import 'package:travel_go/Home/ui/dialog_level.dart';
import 'package:travel_go/Home/ui/menu.dart';
import 'package:travel_go/setting.dart';
import 'package:travel_go/store/ui/store.dart';
import 'package:xtyle/xtyle.dart';

class logined_Page extends StatefulWidget {
  const logined_Page({super.key});

  @override
  State<logined_Page> createState() => _logined_PageState();
}

class _logined_PageState extends State<logined_Page> {
  final stepdb = Get.put(dbSteps()); // 걸음수 컨트롤러
  final packinfos = Get.put(packinfo()); // 걸음수 컨트롤러

  final naverMap = Get.put(LatLngController()); // 네이버 지도 컨트롤러
  bool cameraMove = false; // 카메라 이동이 있었는가?

  final dailys = Get.put(dailyMission()); // 일일미션 컨트롤러
  double levelPercent = 0.735;

  bool openMenu = false;

  final List<String> name = <String>["상점", "명소", "아이템", "랭킹", "설정"];
  final List<IconData> icons = <IconData>[Icons.store, Icons.account_balance_outlined, Icons.auto_awesome_outlined, Icons.trending_up_outlined, Icons.settings_outlined];
  final List<Color> colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.grey];
  final List page = [const storePage(), const attractionPage(), const bottomNavItemPage(), const rankPage(), const settingPage()];

  @override
  void initState() {
    stepdb.initPlatformState(context);
    packinfos.loading(); // 패키지 정보 로딩
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: true, // bottomAppBar 부분까지 확장으로 사용할것인가?
          body: Stack(
            children: [
              maps(context),
              dailys.dailyWalking(context),
              cameraMove // 카메라 움직임이 있을때,
                  ? nowLocation() // 현 위치 갱신 버튼
                  : Container(),
              openMenu // 메뉴를 열었을때,
                  ? Opacity(
                      opacity: 0.6, // 불투명도
                      child: ModalBarrier(
                        dismissible: true, // onDismiss 를 이용한 배경을 닫기
                        onDismiss: () {
                          setState(() {
                            openMenu = !openMenu;
                          });
                        },
                        color: Colors.grey,
                      ),
                    )
                  : Container(),
              openMenu ? menuList(context) : Container(),
              level(),
            ],
          ),
          bottomNavigationBar: bottomAppBar(), // 하단
          // floatingActionButton: menu(),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ],
    );
  }

  // 네이버 지도
  Widget maps(BuildContext context) {
    double left = MediaQuery.of(context).size.width * 0.86;
    double bottom = MediaQuery.of(context).size.height * 0.08;

    return NaverMap(
      options: NaverMapViewOptions(
          minZoom: 5, // 최소 줌 제한
          maxZoom: 19.5, // 최대 줌 제한
          extent: const NLatLngBounds(northEast: NLatLng(44.35, 132.0), southWest: NLatLng(31.43, 122.37)), // 지도 영역 : 한반도 인근
          tiltGesturesEnable: false, // 기울기 제스처
          // locationButtonEnable: true, // 현위치 버튼
          scaleBarEnable: false,
          initialCameraPosition: naverMap.maplatlng,
          logoMargin: EdgeInsets.only(left: left, bottom: bottom)),
      onMapReady: (controller) async {
        naverMap.mapController = controller;
        await naverMap.checkLocation(context); // 위치 권한 및 현 위치 가져오기
        print("네이버 지도 로딩완료");
      },
      // 카메라 움직임 감지
      onCameraChange: (reason, animated) {
        setState(() {
          // 만약, 사용자가 직접 카메라를 움직였다면
          if (reason == NCameraUpdateReason.gesture) {
            cameraMove = true; // 현 위치 버튼 활성화
            naverMap.setCircleVisible(true);
          } else {
            cameraMove = false;
            naverMap.setCircleVisible(false);
          }
        });
      },
    );
  }

  // 레벨
  Widget level() {
    Radius circle = Radius.circular(MediaQuery.of(context).size.width * 0.1);

    return Positioned(
        left: 0,
        bottom: MediaQuery.of(context).size.height * 0.08,
        child: Stack(
          alignment: Alignment.center,
          children: [
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * 0.86,
              lineHeight: MediaQuery.of(context).size.height * 0.03,
              barRadius: circle,
              backgroundColor: Colors.blue[700],
            ),
            InkWell(
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 1500,
                animateFromLastPercent: true,
                width: MediaQuery.of(context).size.width * 0.8,
                lineHeight: MediaQuery.of(context).size.height * 0.025,
                barRadius: circle,
                padding: EdgeInsets.zero,
                percent: levelPercent,
                backgroundColor: Colors.white,
                progressColor: Colors.blue,
                center: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Text(
                        "LV 99",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      WidgetSpan(
                          child: Text(
                        ".${(levelPercent * 100).toInt()}",
                        style: const TextStyle(color: Color.fromARGB(255, 36, 36, 36)),
                      )),
                    ]),
                  ]),
                ),
                alignment: MainAxisAlignment.center,
              ),
              onTap: () {
                levelTip(context); // 레벨 툴팁
              },
            ),
          ],
        ));
  }

  // [하단] - 위젯 배치
  BottomAppBar bottomAppBar() {
    double width = MediaQuery.of(context).size.width * 0.02;
    double top = MediaQuery.of(context).size.height * 0.01;

    return BottomAppBar(
      elevation: 5,
      padding: EdgeInsets.only(left: width, right: width, top: top),
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.grey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [for (int index = 0; index < 5; index++) menuButton(name[index], icons[index], colors[index], page[index])],
      ),
    );
  }

  IconButton menuButton(String name, IconData icon, Color color, Widget page) {
    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Get.to(() => page);
        },
        icon: Column(
          children: [Icon(icon, color: color), XtyleText(name)],
        ));
  }

  // [하단] - 메뉴버튼
  Widget menu() {
    return FloatingActionButton(
      elevation: 2,
      shape: const CircleBorder(),
      backgroundColor: Colors.white,
      child: Icon(openMenu ? Icons.cancel_outlined : Icons.menu, size: MediaQuery.of(context).size.width * 0.08, color: Colors.blue),
      onPressed: () {
        setState(() {
          openMenu = !openMenu; // 클릭하면 반대로 설정
        });
      },
    );
  }

  // 현 위치 갱신
  Widget nowLocation() {
    double mylocationButtonWidth = MediaQuery.of(context).size.width * 0.45;
    double mylocationButtonHeight = MediaQuery.of(context).size.height * 0.06;

    return Positioned(
        bottom: MediaQuery.of(context).size.height * 0.16,
        left: MediaQuery.of(context).size.width / 2 - (mylocationButtonWidth / 2),
        child: SizedBox(
          width: mylocationButtonWidth,
          height: mylocationButtonHeight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(0), side: BorderSide(width: MediaQuery.of(context).size.width * 0.005, color: Colors.blue)),
              onPressed: () {
                setState(() {
                  cameraMove = false;
                });
                naverMap.getMap(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.my_location_rounded, color: Colors.blue),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  const XtyleText(
                    "현 위치로 이동",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )),
        ));
  }
}
