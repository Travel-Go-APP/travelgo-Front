import 'dart:async';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:travel_go/Attraction/function/attraction_info.dart';
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
  double percent = 0.0; // 현재 진행률

  final List<String> country = <String>['서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주'];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        attractInfos.updateValue(); // 명소 진행률 가져오기
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
    return _scrollController != null && _scrollController!.hasClients && _scrollController!.offset > (MediaQuery.of(context).padding.top * 19);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            appbar(), // 상단
          ];
        },
        body: countryList(),
      ),
    );
  }

  // 상단
  SliverAppBar appbar() {
    return SliverAppBar(
      backgroundColor: _isShrink ? Colors.green : Colors.white,
      shadowColor: Colors.black, // 상단 스크롤 했을때 그림자
      floating: false, // 스크롤을 했을시 bottom만 보이게 하고 싶을때
      pinned: true, // 스크롤을 했을시, 상단이 고정되게 하고 싶을때
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        color: Colors.black,
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
            attractInfos.percentValue = 0; // 진행률 초기화?
          });
        },
      ),
      title: const XtyleText("명소", style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: !_isShrink,
      expandedHeight: MediaQuery.of(context).size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top * 3.5),
            child: Column(
              children: [
                koreanMaps(), // 대한민국 지도
                percentText(), // 현재 진행률 (텍스트)
                percentBar(), // 현재 진행률 (퍼센트)
              ],
            )),
      ),
      bottom: _isShrink
          ? PreferredSize(
              preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top * 1),
              child: Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const XtyleText("진행률", style: TextStyle(fontWeight: FontWeight.bold)),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width * 0.7,
                        percent: percent,
                        progressColor: Colors.green[800],
                        backgroundColor: Colors.white,
                      ),
                      XtyleText(
                        "${attractInfos.percentValue}%",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800]),
                      ),
                    ],
                  )))
          : null,
    );
  }

  // 대한민국 지도
  Widget koreanMaps() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: SimpleMap(
        instructions: SMapSouthKorea.instructions,
        countryBorder: const CountryBorder(color: Colors.grey), // 도시 경계선
        defaultColor: Colors.white, // 기본 색상
        colors: mapColor.toMap(),
        callback: (id, name, tapDetails) {
          print("$name : $id"); // 이동 가능 할듯?
        },
      ),
    );
  }

  // 현재 진행률 (텍스트)
  Widget percentText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        XtyleText("전체 진행률", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055, fontWeight: FontWeight.bold)),
        AnimatedFlipCounter(
          curve: Curves.easeInOutQuad,
          wholeDigits: 2,
          value: attractInfos.percentValue,
          prefix: " : ",
          suffix: "%",
          duration: const Duration(milliseconds: 2500), // 퍼센트와 시간을 맞추기 위해 -100
          textStyle: TextStyle(color: Colors.blue, fontFamily: 'GmarketSans', fontSize: MediaQuery.of(context).size.width * 0.055, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // 현재 진행률 (퍼센트)
  Widget percentBar() {
    return LinearPercentIndicator(
      curve: Curves.easeInOutQuad,
      animation: true,
      animationDuration: 2500,
      padding: const EdgeInsets.only(left: 30, right: 30),
      lineHeight: MediaQuery.of(context).size.height * 0.015,
      percent: percent,
      progressColor: Colors.green,
      barRadius: Radius.circular(MediaQuery.of(context).size.width * 0.05),
    );
  }

  // 지역 리스트
  ListView countryList() {
    return ListView.builder(
      itemCount: country.length,
      itemBuilder: (context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.08,
          margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0, side: const BorderSide(color: Colors.white)),
              onPressed: () {},
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
                      XtyleText(country[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.055, color: Colors.black)),
                    ],
                  ),
                  RichText(
                    text: TextSpan(children: [
                      WidgetSpan(
                          child: XtyleText(
                        "100%",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.045, fontFamily: 'GmarketSans', color: Colors.blue),
                      )),
                      WidgetSpan(
                          child: XtyleText(
                        "(10/10)",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, fontFamily: 'GmarketSans', color: Colors.grey),
                      )),
                    ]),
                  ),
                ],
              )),
        );
      },
    );
  }
}
