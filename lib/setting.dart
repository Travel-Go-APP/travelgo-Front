import 'package:flutter/material.dart';
import 'package:xtyle/xtyle.dart';

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [XtyleText("SETTING", style: TextStyle(fontSize: 35))],
        ),
      ),
    );
  }
}

                //       ElevatedButton(
                // onPressed: () async {
                //   await login_model.logout();
                //   setState(() {
                //     Get.off(() => const login_Page());
                //   });
                // },
                // child: const Text("카카오 로그아웃")),