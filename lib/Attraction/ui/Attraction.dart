import 'package:flutter/material.dart';
import 'package:xtyle/xtyle.dart';

class attractionPage extends StatefulWidget {
  const attractionPage({super.key});

  @override
  State<attractionPage> createState() => _attractionPageState();
}

class _attractionPageState extends State<attractionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            XtyleText("ATTRACTION", style: TextStyle(fontSize: 35))
          ],
        ),
      ),
    );
  }
}