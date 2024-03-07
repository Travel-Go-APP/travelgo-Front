import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/Attraction/ui/Attraction.dart';
import 'package:travel_go/Rank/ui/Rank.dart';
import 'package:travel_go/collection/ui/collection.dart';
import 'package:travel_go/package_Info.dart';
import 'package:travel_go/setting.dart';
import 'package:xtyle/xtyle.dart';

Widget menuList(BuildContext context) {
  final packinfos = Get.put(packinfo()); // 걸음수 컨트롤러

  return Positioned(
    left: MediaQuery.of(context).size.width / 6,
    bottom: MediaQuery.of(context).size.height * 0.25,
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Image.asset('assets/images/Logo.png', scale: MediaQuery.of(context).devicePixelRatio * 1),
      XtyleText("현재 버전: ${packinfos.version}"),
      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      menuButton(context, "명소", Icons.account_balance_outlined, Colors.green, const attractionPage()),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      menuButton(context, "아이템", Icons.auto_awesome_outlined, Colors.blue, const collectionPage()),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      menuButton(context, "랭킹", Icons.trending_up_outlined, Colors.yellow, const rankPage()),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      menuButton(context, "설정", Icons.settings_outlined, Colors.grey, const settingPage()),
    ]),
  );
}

Widget menuButton(BuildContext context, String name, IconData icon, Color color, Widget page) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.5,
    height: MediaQuery.of(context).size.height * 0.08,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 1, color: color),
        backgroundColor: color,
        elevation: 3
      ),
      onPressed: () {
        Get.to(() => page);
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Icon(icon, size: MediaQuery.of(context).size.height * 0.04, color: Colors.white),
        Stack(
          children: [
            XtyleText(name, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=2..color=const Color.fromARGB(255, 114, 114, 114))),
            XtyleText(name, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, color: Colors.white)),
          ],
        )
      ]),
    ),
  );
}
