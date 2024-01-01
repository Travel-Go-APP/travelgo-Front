import 'package:flutter/material.dart';

void main() {
  runApp(const TravelGoApp());
}

class TravelGoApp extends StatelessWidget {
  const TravelGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Travel_GO",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});
	@override
    Widget build(BuildContext context) {
    	return const Scaffold(
        	appBar: InfoBar(),	// AppBar
          body: MapFrame(),
      );	// Scaffold
    }
}

class InfoBar extends StatelessWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Travel_GO'),
        centerTitle: true,
        leading: const IconButton(icon: Icon(Icons.rectangle), onPressed: null),
        leadingWidth: 100,
        actions: const [
          IconButton(icon: Icon(Icons.circle, color: Color(0xFFFF0000),), onPressed: null),
          IconButton(icon: Icon(Icons.circle, color: Color(0xFF05FF00),), onPressed: null),
          IconButton(icon: Icon(Icons.circle, color: Color(0xFFF9FF00),), onPressed: null),
        ],
      ),
    );
  }

}

class MapFrame extends StatelessWidget {
  const MapFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Expanded(child: Column(
            children: [
              Text("MAP",
              textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
              ),)
              ],
          )
          ),
          Container(
            alignment: Alignment.center,
            color : Colors.blue, 
            width : 100,           
            height : 50,            
            margin : const EdgeInsets.only(bottom: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                ),
              child: const Text(
                "Search",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  ),
              onPressed: () {  },
            )
          ),
          Container(
            alignment: Alignment.center,
            color : Colors.blue,   
            width: double.infinity,
            height : 25,
            child: const Text(
              "LV",
              textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),),
          )
        ],
      ),
    );
}
}