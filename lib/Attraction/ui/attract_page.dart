import 'package:favicon/favicon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xtyle/xtyle.dart';

class attackPage extends StatefulWidget {
  const attackPage({super.key});

  @override
  State<attackPage> createState() => _attackPageState();
}

class _attackPageState extends State<attackPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: MediaQuery.of(context).size.width * 0.01),
                  ),
                ),
                child: Image.asset(
                  "assets/images/Dokdo.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).padding.top,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  )),
            ],
          ),
          // 명소 정보
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: MediaQuery.of(context).size.width * 0.03),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.landscape_rounded, color: Colors.green, size: MediaQuery.of(context).size.width * 0.08),
                      XtyleText(
                        "독도",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.08),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.grey),
                      XtyleText("경상북도 울릉군 울릉읍 독도리 1-96번지", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.032, color: Colors.grey))
                    ],
                  ),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              child: XtyleText(
                "대한민국의 울릉도와 일본의 오키노시마 사이에 있으며, 울릉도에서 동남쪽으로 87.4km 떨어져 있고 오키노시마에서는 서북쪽으로 157km 떨어져 있다."
                "독도에서 외부로 연결되는 교통수단은 선박과 헬리콥터가 있다. 이 둘을 제외한 다른 교통수단을 운용하기엔 섬의 면적이 협소하기 때문이다. 외부로 연결되는 교통편도 사실상 울릉도 뿐이다."
                "대한민국의 부속 도서 중 한반도 본토에서 가장 멀리 떨어져 있는 섬"
                "대한민국과 일본에서는 독도를 섬(island)으로 규정하지만, 국제해양법상 암초(rocks)로 분류된다."
                "섬을 \"사람이 살며 경제 활동이 가능한 섬(island)\"과 \"그렇지 못한 암초(rocks)\"로 구별하며, "
                "독도가 국제법상 섬으로 인정받지 못하는 까닭은 사람이 살고는 있으나, 독도 안에서 스스로 경제 활동을 할 수 없기 때문이다. "
                "다시 말해 섬에 마을을 건설하여 스스로 살 수 없다는 이야기. 섬의 정의에는 거주민 뿐만 아니라 스스로 경제 활동을 할 수 있어야 한다는 단서가 붙기 때문에 섬으로 인정받지 못하고 있다.",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height,
            child: ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse("https://namu.wiki/w/%EB%8F%85%EB%8F%84"));
              },
              child: const XtyleText(
                "자세히 알기 \n (최초 1회 EXP 500)",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
