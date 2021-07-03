import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/main.dart';
import 'package:listas/pages/lista/listas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int tag = 1;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ListasPage(),
      Container(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        actions: [
          IconButton(
            icon: CircleAvatar(
              child: Text('R'),
            ),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Listas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Despensa',
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.toNamed("/lista/add");
          // Navigator.pushNamed(context, "/lista/add");
        },
        child: Icon(Icons.add),
        heroTag: tag,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
