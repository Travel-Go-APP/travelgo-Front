import 'dart:async';
import 'dart:io';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:travel_go/Attraction/function/attraction_info.dart';
import 'package:travel_go/Attraction/ui/country_page.dart';
import 'package:travel_go/Home/ui/menu.dart';
import 'package:travel_go/style.dart';
import 'package:xtyle/xtyle.dart';

class attractionPage extends StatefulWidget {
  const attractionPage({super.key});

  @override
  State<attractionPage> createState() => _attractionPageState();
}

class _attractionPageState extends State<attractionPage> {
  final attractInfos = Get.put(attractInfo());
  late ScrollController? _scrollController;
  bool lastStatus = true;
  double percent = 0.0; // 현재 수집률

  final List<String> country = <String>['서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주'];
  int countryPercent = 100;
  int countryCount = 30;
  int countryCheck = 30;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        attractInfos.updateValue(); // 명소 수집률 가져오기
        percent = 0.83;
      });
    });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_isShrink != lastStatus) {
          setState(() {
            lastStatus = _isShrink;
          });
        }
      }); // 상단 스크롤 검사
  }

  bool get _isShrink {
    return _scrollController != null && _scrollController!.hasClients && _scrollController!.offset > (MediaQuery.of(context).size.height * 0.8 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      controller: _scrollController,
      slivers: [
        appbar(),
        SliverToBoxAdapter(
          child: Container(
            color: const Color.fromARGB(255, 163, 220, 253),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.05),
                      topRight: Radius.circular(MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01)),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ),
              ],
            ),
          ),
        ),
        countryList(),
      ],
    ));
  }

  // 상단
  SliverAppBar appbar() {
    return SliverAppBar(
      backgroundColor: _isShrink ? Colors.green : const Color.fromARGB(255, 163, 220, 253),
      shadowColor: Colors.black, // 상단 스크롤 했을때 그림자
      floating: false, // 스크롤을 했을시 bottom만 보이게 하고 싶을때
      pinned: true, // 스크롤을 했을시, 상단이 고정되게 하고 싶을때
      stretch: true, // 오버 스크롤시 영역을 채우는가?
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        color: Colors.black,
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
            attractInfos.percentValue = 0; // 수집률 초기화?
          });
        },
      ),
      title: XtyleText("명소", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055)),
      centerTitle: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.8,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Container(
            color: const Color.fromARGB(255, 163, 220, 253),
            margin: Platform.isAndroid ? EdgeInsets.only(top: MediaQuery.of(context).padding.top * 2.5) : EdgeInsets.only(top: MediaQuery.of(context).padding.top * 1.5),
            child: Column(
              children: [
                koreanMaps(), // 대한민국 지도
                Column(
                  children: [
                    percentText(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                    percentBar(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    completeGift(),
                  ],
                )
              ],
            )),
      ),
      bottom: _isShrink
          ? PreferredSize(
              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.04),
              child: Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const XtyleText("수집률", style: TextStyle(fontWeight: FontWeight.bold)),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width * 0.7,
                        percent: percent,
                        progressColor: Colors.green[800],
                        backgroundColor: Colors.white,
                      ),
                      XtyleText(
                        "${attractInfos.percentValue}%",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  )))
          : null,
    );
  }

  // 대한민국 지도
  Widget koreanMaps() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.height * 0.03),
          child: SimpleMap(
            instructions: SMapSouthKorea.instructions,
            countryBorder: const CountryBorder(color: Color.fromARGB(130, 255, 255, 255)), // 도시 경계선
            defaultColor: Colors.green[500], // 기본 색상
            // callback: (id, name, tapDetails) {
            //   print("$name : $id"); // 이동 가능 할듯?
            // },
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.08,
          bottom: MediaQuery.of(context).size.height * 0.06,
          child: Container(
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              ),
                            ],
                            border: Border.all(width: 2, color: Colors.green),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.03,
                            )),
                        margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05, bottom: MediaQuery.of(context).size.width * 0.05),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.025),
                          child: InkWell(
                            onTap: () {
                              print("터치");
                            },
                            child: Image.asset(
                              'assets/images/Dokdo.png',
                              fit: BoxFit.cover,
                              // color: Colors.grey,
                              // colorBlendMode: BlendMode.color,
                            ),
                          ),
                        )),
          )
      ],
    );
  }

  // 현재 수집률 (텍스트)
  Widget percentText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        XtyleText("전체 수집률", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold)),
        AnimatedFlipCounter(
          curve: Curves.easeInOutQuad,
          wholeDigits: 2,
          value: attractInfos.percentValue,
          prefix: " : ",
          suffix: "%",
          duration: const Duration(milliseconds: 2500), // 퍼센트와 시간을 맞추기 위해
          textStyle: TextStyle(color: Colors.blue, fontFamily: 'GmarketSans', fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // 현재 수집률 (퍼센트)
  Widget percentBar() {
    return LinearPercentIndicator(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
      curve: Curves.easeInOutQuad,
      animation: true,
      animationDuration: 2500,
      lineHeight: MediaQuery.of(context).size.height * 0.015,
      percent: percent,
      progressColor: Colors.green,
      barRadius: Radius.circular(MediaQuery.of(context).size.width * 0.05),
      backgroundColor: Colors.white,
    );
  }

  Widget completeGift() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Tooltip(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          richMessage: const TextSpan(children: [WidgetSpan(child: XtyleText("개발자의 편지", style: TextStyle(color: Colors.orange)))]),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [const XtyleText("100% 보상 :"), Image.asset("assets/images/gift3.png", scale: MediaQuery.of(context).size.height * 0.03)],
              ))),
    );
  }

  // 지역 리스트
  SliverList countryList() {
    return SliverList.builder(
        itemCount: country.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0, side: const BorderSide(color: Colors.white)),
                onPressed: () {
                  Get.to(() => countryPage(
                        country: country[index],
                        percent: countryPercent,
                        count: countryCount,
                        check: countryCheck,
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              maxRadius: MediaQuery.of(context).size.height * 0.022,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: MediaQuery.of(context).size.height * 0.02,
                              child: const Icon(Icons.check, color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                        XtyleText(country[index], style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055, color: Colors.black, fontWeight: FontWeight.w300)),
                      ],
                    ),
                    RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                            child: XtyleText(
                          "$countryPercent% ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.045, fontFamily: 'GmarketSans', color: Colors.blue),
                        )),
                        WidgetSpan(
                            child: XtyleText(
                          "($countryCheck/$countryCount)",
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, fontFamily: 'GmarketSans', color: Colors.grey),
                        )),
                      ]),
                    ),
                  ],
                )),
          );
        });
  }
}
