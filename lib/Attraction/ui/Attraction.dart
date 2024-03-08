import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:countries_world_map/countries_world_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:travel_go/Attraction/function/attraction_info.dart';
import 'package:xtyle/xtyle.dart';

class attractionPage extends StatefulWidget {
  const attractionPage({super.key});

  @override
  State<attractionPage> createState() => _attractionPageState();
}

class _attractionPageState extends State<attractionPage> {
  final attractInfos = Get.put(attractInfo());

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () async {
      setState(() {
        attractInfos.updateValue();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const XtyleText("명소"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
                attractInfos.percentValue = 0;
              });
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height * 0.5,
              child: SimpleMap(
                instructions: SMapSouthKorea.instructions,
                countryBorder: const CountryBorder(color: Colors.grey), // 도시 경계선
                defaultColor: Colors.white, // 기본 색상
                colors: SMapSouthKoreaColors(
                  kr11: Colors.red,
                  kr26: Colors.blue,
                  kr27: Colors.yellow,
                  kr28: Colors.indigo,
                  kr29: Colors.green,
                  kr30: Colors.green,
                  kr31: Colors.black,
                  kr41: Colors.purple,
                  kr42: Colors.brown,
                  kr43: Colors.pink,
                  kr44: Colors.deepPurple,
                  kr45: Colors.red,
                  kr46: Colors.orange,
                  kr47: Colors.blue,
                  kr48: Colors.indigo,
                  kr49: Colors.orange,
                  kr50: Colors.green,
                ).toMap(),
                callback: (id, name, tapDetails) {
                  print("$name : $id"); // 이동 가능 할듯?
                },
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const XtyleText("현재 진행률 : ", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            AnimatedFlipCounter(
              curve: Curves.decelerate,
              wholeDigits: 2,
              value: attractInfos.percentValue,
              suffix: "%",
              duration: const Duration(milliseconds: 1400), // 퍼센트와 시간을 맞추기 위해 -100
            )
          ]),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1500,
            lineHeight: MediaQuery.of(context).size.height * 0.015,
            percent: 0.83,
            progressColor: Colors.green,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  attractInfos.updateValue2();
                });
              },
              child: Text("변경"))
        ],
      ),
    );
  }
}
