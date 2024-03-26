import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/Attraction/function/attraction_info.dart';
import 'package:travel_go/Attraction/ui/attract_page.dart';
import 'package:travel_go/Attraction/ui/dialog_Hint.dart';
import 'package:xtyle/xtyle.dart';

class countryPage extends StatefulWidget {
  final String? country;
  final int? percent;

  const countryPage({super.key, this.country, this.percent});

  @override
  State<countryPage> createState() => _countryPageState();
}

class _countryPageState extends State<countryPage> {
  final attractInfos = Get.put(attractInfo());
  late ScrollController? _scrollController;
  bool lastStatus = true;
  late String? name = widget.country;
  late int? percent = widget.percent;

  @override
  void initState() {
    super.initState();
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
    return _scrollController != null && _scrollController!.hasClients && _scrollController!.offset > kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: countryAppbar(), // 지역별 명소 상단
      body: countryList(), // 지역별 명소 리스트
    );
  }

  // 지역별 명소 상단
  AppBar countryAppbar() {
    return AppBar(
      backgroundColor: _isShrink ? Colors.green : Colors.white,
      shadowColor: Colors.black,
      title: XtyleText(name ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
      centerTitle: false,
      actions: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: XtyleText(
                    "수집률 : ",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
                  )),
                  WidgetSpan(
                      child: XtyleText(
                    "$percent%",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, color: _isShrink ? Colors.white : attractInfos.attractChageColor(percent!)),
                  )),
                ]),
              ),
              Obx(() => ElevatedButton(
                    onPressed: attractInfos.openCheck.value
                        ? () async {
                            await attractInfos.updateHint();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(0)),
                    child: const Icon(Icons.delete),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  // 지역별 명소 리스트
  Widget countryList() {
    double margin1 = MediaQuery.of(context).size.width * 0.05;
    double margin2 = MediaQuery.of(context).size.width * 0.02;

    return GetBuilder<attractInfo>(
        builder: (info) => ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: info.countryCount[info.country.indexOf(name!)],
              itemBuilder: (context, index) {
                return Obx(() => Container(
                    margin: EdgeInsets.only(left: margin1, right: margin1, top: margin2, bottom: margin2),
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 2,
                                backgroundColor: info.openCheck.value ? Colors.white : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
                                ),
                                side: BorderSide(color: info.openCheck.value ? const Color.fromARGB(255, 0, 133, 4) : Colors.black, width: MediaQuery.of(context).size.width * 0.005)),
                            onPressed: () {
                              info.openCheck.value ? Get.to(() => const attackPage()) : dialogHint(context);
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              info.openCheck.value
                                  ? Image.asset('assets/images/Dokdo.png', scale: MediaQuery.of(context).size.width * 0.018)
                                  : Image.asset('assets/images/Logo.png', scale: MediaQuery.of(context).size.width * 0.018),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [const XtyleText("??? ???"), XtyleText(info.openCheck.value ? "독도는 우리땅" : "??? ??? ???")],
                              )
                            ]),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: info.openCheck.value ? const Color.fromARGB(255, 0, 133, 4) : Colors.black,
                                      radius: MediaQuery.of(context).size.width * 0.05,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: info.openCheck.value ? Colors.green : Colors.white,
                                      radius: MediaQuery.of(context).size.width * 0.045,
                                      child: XtyleText("${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                                Obx(() => Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  decoration: BoxDecoration(
                                    color: Colors.white, 
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
                                    border: Border.all(width: MediaQuery.of(context).size.width * 0.005, color: info.openCheck.value ? const Color.fromARGB(255, 0, 133, 4) : Colors.black)
                                    ),
                                  child: XtyleText(info.openCheck.value ? "독도" : "??", style: const TextStyle(fontWeight: FontWeight.bold)),
                                ))
                              ],
                            )),
                      ],
                    )));
              },
            ));
  }
}
