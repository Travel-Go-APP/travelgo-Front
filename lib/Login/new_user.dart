import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/Login/loginedPage.dart';
import 'package:xtyle/xtyle.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(40), // 외부여백
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const XtyleText(
              "Welcome !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            const XtyleText(
              "서비스에서 사용할 \n 닉네임을 작성해주세요. \n (최초 1회 한정)",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30), // 외부여백
                  child: const TextField(
                    decoration: InputDecoration(labelText: "뭐함"),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Get.off(() => const logined_Page());
                      });
                    },
                    child: const XtyleText("사용하기"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
