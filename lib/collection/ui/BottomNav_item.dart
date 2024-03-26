import 'package:flutter/material.dart';
import 'package:travel_go/collection/ui/collection.dart';
import 'package:travel_go/collection/ui/inventory.dart';
import 'package:xtyle/xtyle.dart';

class bottomNavItemPage extends StatefulWidget {
  const bottomNavItemPage({super.key});

  @override
  State<bottomNavItemPage> createState() => _bottomNavItemPageState();
}

class _bottomNavItemPageState extends State<bottomNavItemPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const inventoryPage(),
    const collectionPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(children: [
            const WidgetSpan(child: Icon(Icons.auto_awesome_outlined)),
            WidgetSpan(
              child: XtyleText(
                " 아이템",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ),
          ]),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: '인벤토리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '도감',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
