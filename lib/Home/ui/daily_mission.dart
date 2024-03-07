import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:travel_go/Home/function/db_steps.dart';
import 'package:xtyle/xtyle.dart';

class dailyMission extends GetxController {
  final stepdb = Get.put(dbSteps()); // 걸음수 컨트롤러
  int walking = 0;

// 일일미션 (걷기)
  Widget dailyWalking(BuildContext context) {
    double circleRadius = MediaQuery.of(context).size.height * 0.005; // 원형 사이즈

    return Positioned(
        top: MediaQuery.of(context).padding.top * 0.99,
        left: MediaQuery.of(context).size.width * 0.03,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.94,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            color: const Color.fromARGB(143, 255, 255, 255),
            border: Border.all(width: 1, color: Colors.green),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도
                spreadRadius: 2, // 그림자 확산 범위
                blurRadius: 4, // 그림자의 흐림 정도
                offset: Offset(0, 2), // 그림자의 위치
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => LinearPercentIndicator(
                    linearGradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                      Color.fromARGB(255, 127, 247, 131),
                      Colors.green,
                    ]),
                    animation: true,
                    animationDuration: 1500,
                    animateFromLastPercent: true,
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.7,
                    lineHeight: MediaQuery.of(context).size.height * 0.023,
                    barRadius: const Radius.circular(8),
                    percent: stepdb.steps < 1000 ? stepdb.steps.toDouble() * 0.001 : 1.0,
                    backgroundColor: Colors.white,
                    center: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5),
                      child: stepdb.steps < 100
                          ? XtyleText("${stepdb.steps} / 100")
                          : stepdb.steps < 500
                              ? XtyleText("${stepdb.steps} / 500")
                              : stepdb.steps < 1000
                                  ? XtyleText("${stepdb.steps} / 1000")
                                  : const XtyleText("일일 걸음수 완료 !"),
                    ),
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Row(
                    children: [
                      Obx(() => Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          stepdb.steps < 100
                              ? giftList1(context)
                              : stepdb.steps < 500
                                  ? giftList2(context)
                                  : giftList3(context),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: stepdb.steps >= 1000 ? () {} : null,
                    style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(0)),
                    child: stepdb.steps < 100 
                    ? Image.asset('assets/images/gift1.png', scale: MediaQuery.of(context).size.height * 0.03, color: stepdb.steps < 100 ? Colors.grey : null) 
                    : stepdb.steps < 500
                      ? Image.asset('assets/images/gift2.png', scale: MediaQuery.of(context).size.height * 0.03, color: stepdb.steps < 500 ? Colors.grey : null)
                      : Image.asset('assets/images/gift3.png', scale: MediaQuery.of(context).size.height * 0.03, color: stepdb.steps < 1000 ? Colors.grey : null),
                  ),
                ],
              )),
            ],
          ),
        ));
  }
}

// 1단계 보상 (500)
RichText giftList1(BuildContext context) {
  return RichText(
      text: TextSpan(
    children: [
      TextSpan(children: [WidgetSpan(child: Image.asset('assets/images/gift1.png', scale: MediaQuery.of(context).size.height * 0.04))]),
      const TextSpan(
        text: ' 1단계 보상 : ',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: '500',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: ' EXP ',
        style: TextStyle(color: Colors.black, fontFamily: 'GmarketSans'),
      ),
    ],
  ));
}

// 2단계 보상 (1500)
RichText giftList2(BuildContext context) {
  return RichText(
      text: TextSpan(
    children: [
      TextSpan(children: [WidgetSpan(child: Image.asset('assets/images/gift2.png', scale: MediaQuery.of(context).size.height * 0.04))]),
      const TextSpan(
        text: ' 2단계 보상 : ',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: '500',
        style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 212, 191, 0), fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: ' 엽전 ',
        style: TextStyle(color: Colors.black, fontFamily: 'GmarketSans'),
      ),
    ],
  ));
}

// 3단계 보상 (3000)
RichText giftList3(BuildContext context) {
  return RichText(
      text: TextSpan(
    children: [
      TextSpan(children: [WidgetSpan(child: Image.asset('assets/images/gift3.png', scale: MediaQuery.of(context).size.height * 0.04))]),
      const TextSpan(
        text: ' 3단계 보상 : ',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: '일반',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: ' ~ ',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: '전설',
        style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 212, 191, 0), fontFamily: 'GmarketSans'),
      ),
      const TextSpan(
        text: ' 아이템 뽑기권 ',
        style: TextStyle(color: Colors.black, fontFamily: 'GmarketSans'),
      ),
    ],
  ));
}
