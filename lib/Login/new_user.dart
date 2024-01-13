import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/Login/loginedPage.dart';
import 'package:travel_go/style.dart';
import 'package:xtyle/xtyle.dart';
import 'nick_check.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController nicknameController = TextEditingController();
  bool fillForm = false;
  bool validatorNickname = true;
  String? nickname = '';
  String? Errorname = '';

  checkfill() {
    // 닉네임 필드가 채워져 있는지 검사
    fillForm = nicknameController.text.isNotEmpty &&
        nicknameController.text.length >= 2;
    if (!fillForm) {
      Errorname = '';
      validatorNickname = false;
    }
  }

  checkvalidator() {
    // 1차 유효성 검사
    if (nicknameController.text
        .contains(RegExp(r'[^\uAC00-\uD7A3A-Za-z0-9\s]', unicode: true))) {
      // 완성형 한글, 알파벳, 숫자, 공백을 제외한 모든 문자
      validatorNickname = false;
      Errorname = "특수문자가 포함되어 있습니다.";
    } else if (nicknameController.text.contains(RegExp(r'[\s]'))) {
      // 공백 문자
      validatorNickname = false;
      Errorname = "공백이 있어서는 안됩니다.";
    } else {
      // 문제 없다면
      validatorNickname = true;
      Errorname = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(40), // 외부여백
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            XtyleText(
              "Welcome !",
              style: welcomeTitle,
            ),
            XtyleText(
              "서비스에서 사용할 \n 닉네임을 작성해주세요 \n (최초 1회 한정)",
              textAlign: TextAlign.center,
              style: welcomeText,
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30), // 외부여백
                  child: TextFormField(
                    controller: nicknameController,
                    maxLength: 8,
                    decoration: InputDecoration(
                        labelText: "특수문자, 공백 제외 2~8자",
                        contentPadding:
                            const EdgeInsets.all(5), // 텍스트 가려지는것을 방지?
                        suffixIcon: GestureDetector(
                            onTap: fillForm // 텍스트 필드 지우기
                                ? () {
                                    setState(() {
                                      nicknameController.clear();
                                      validatorNickname = true;
                                      Errorname = '';
                                      checkfill();
                                    });
                                  }
                                : null,
                            child: Icon(Icons.cancel,
                                color: fillForm
                                    ? Colors.red
                                    : Colors.transparent))),
                    onChanged: (value) {
                      // 텍스트가 입력될때마다 검사
                      setState(() {
                        checkfill();
                        checkvalidator();
                      });
                    },
                    // onSaved: (value) {
                    //   setState(() {
                    //     nickname = value;
                    //   });
                    // },
                  ),
                ),
                ElevatedButton(
                    onPressed:
                        fillForm && validatorNickname // 필드가 채워져있고, 1차 유효성을 통과
                            ? () {
                                setState  (() async {
                                  await checkNick(nicknameController.text);
                                  checkValidator(nicknameController.text);
                                  // Get.off(() => const logined_Page());
                                });
                              }
                            : null,
                    child: XtyleText(fillForm
                        ? validatorNickname
                            ? "닉네임 검사"
                            : Errorname
                        : "닉네임을 입력해주세요"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkValidator (String name) {
    //boolean 함수 넣고 다이얼로그 조절
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: alertStyle,
              title: Container(
                alignment: Alignment.center,
                child: const XtyleText("사용 가능"),
              ),
              content: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      XtyleText(
                        "\"$name\"",
                        style: nameStyle,
                      ),
                      XtyleText(
                        "사용이 가능합니다.",
                        style: validatorStyle,
                      )
                    ],
                  )),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.5,
                  child: ElevatedButton(
                      style: addStyle,
                      onPressed: () async {
                        setState(() {
                          Navigator.of(context).pop(); // 알림창을 닫고
                          Get.off(() => const logined_Page()); // 메인 페이지로 이동
                        });
                      },
                      child: const XtyleText("생성하기")),
                ),
              ],
            ));
  }
}
