import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:travel_go/Home/function/Geolocation.dart';
import 'package:travel_go/Home/function/db_steps.dart';
import 'package:travel_go/package_Info.dart';
import 'package:travel_go/Home/ui/daily_mission.dart';
import 'package:travel_go/Home/ui/dialog_level.dart';
import 'package:travel_go/Home/ui/menu.dart';
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
              openMenu ? menuList(context) : Container()
            ],
          ),
          bottomNavigationBar: bottom(), // 하단
          floatingActionButton: menu(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ],
    );
  }

  // 네이버 지도
  Widget maps(BuildContext context) {
    double left = MediaQuery.of(context).size.width * 0.86;
    double bottom = MediaQuery.of(context).size.height * 0.06;

    return NaverMap(
      options: NaverMapViewOptions(
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
          } else {
            cameraMove = false;
          }
        });
      },
    );
  }

  // [하단]
  Stack bottom() {
    return Stack(
      children: [
        bottomAppBar(),
        // lvPercent(),
      ],
    );
  }

  // [하단] - 위젯 배치
  BottomAppBar bottomAppBar() {
    return BottomAppBar(
      height: MediaQuery.of(context).size.height * 0.055,
      color: Colors.blue[100],
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(children: [WidgetSpan(child: Image.asset('assets/images/diamond.png', scale: 3.5))]),
              const TextSpan(children: [
                WidgetSpan(
                    child: XtyleText(
                  " Diamond IV",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))
              ]),
            ]),
          ),
          InkWell(
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1500,
              animateFromLastPercent: true,
              width: MediaQuery.of(context).size.width * 0.3,
              lineHeight: MediaQuery.of(context).size.height * 0.3,
              barRadius: const Radius.circular(8),
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
              setState(() {
                levelTip(context); // 레벨 툴팁
              });
            },
          ),
        ],
      ),
    );
  }

  // [하단] - 다음 레벨까지 남은 레벨 퍼센트 (백분율)
  Widget lvPercent() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.00,
      child: InkWell(
        child: LinearPercentIndicator(
          animation: true,
          animationDuration: 1500,
          animateFromLastPercent: true,
          width: MediaQuery.of(context).size.width * 0.3,
          lineHeight: MediaQuery.of(context).size.height * 0.005,
          padding: EdgeInsets.zero,
          percent: levelPercent,
          backgroundColor: Colors.white,
          progressColor: Colors.blue,
          center: XtyleText("${levelPercent * 100}%"),
          alignment: MainAxisAlignment.center,
        ),
        onTap: () {
          setState(() {
            levelTip(context); // 레벨 툴팁
          });
        },
      ),
    );
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
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.16,
      left: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              cameraMove = false;
            });
            naverMap.getMap();
          },
          child: const XtyleText("현 위치로 이동")),
    );
  }
}
