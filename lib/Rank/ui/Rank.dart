import 'package:flutter/material.dart';
import 'package:xtyle/xtyle.dart';

class rankPage extends StatefulWidget {
  const rankPage({super.key});

  @override
  State<rankPage> createState() => _rankPageState();
}

class _rankPageState extends State<rankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            XtyleText("RANK", style: TextStyle(fontSize: 35))
          ],
        ),
      ),
    );
  }
}