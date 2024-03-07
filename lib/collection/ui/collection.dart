import 'package:flutter/material.dart';
import 'package:xtyle/xtyle.dart';

class collectionPage extends StatefulWidget {
  const collectionPage({super.key});

  @override
  State<collectionPage> createState() => _collectionPageState();
}

class _collectionPageState extends State<collectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(left: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            XtyleText("COLLECTION", style: TextStyle(fontSize: 35))
          ],
        ),
      ),
    );
  }
}