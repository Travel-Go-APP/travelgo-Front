import 'package:flutter/material.dart';
import 'package:travel_go/style.dart';
import 'package:xtyle/xtyle.dart';

// LEVEL 관련 툴팁
Future<void> levelTip(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: alertStyle,
              title: Container(
                alignment: Alignment.center,
                child: const XtyleText("LEVEL TIP"),
              ),
              content: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      XtyleText(
                        "현재 레벨 : 56",
                        style: nameStyle,
                      ),
                      XtyleText(
                        "수집 가능한 조사 범위 : 6.5m",
                        style: validatorStyle,
                      ),
                      XtyleText(
                        "경험치 획득량 : 125%",
                        style: validatorStyle,
                      ),
                    ],
                  )),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      style: addStyle,
                      onPressed: () async {
                          Navigator.of(context).pop(); // 알림창을 닫고
                      },
                      child: const XtyleText("닫기")),
                ),
              ],
            ));
  }