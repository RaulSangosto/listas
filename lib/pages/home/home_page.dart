import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas/controller/theme_data.dart';
import 'package:listas/pages/home/listas_page.dart';

import 'despensa_page.dart';

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
      DespensaPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemeData.bgColor,
        foregroundColor: MyThemeData.textColorDark,
        toolbarHeight: 80,
        elevation: 0,
        title: Text(
          selectedIndex == 0 ? "Mis Listas" : "Mi Despensa",
          style: MyThemeData.h3,
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: MyThemeData.bgColorDark,
              foregroundColor: MyThemeData.primaryColor,
              child: Text('R'),
            ),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        unselectedItemColor: MyThemeData.primaryColor50,
        selectedItemColor: MyThemeData.primaryColor,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedIconTheme: IconThemeData(size: 24),
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_rounded,
            ),
            label: "Mis Listas",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.storefront_rounded,
            ),
            label: "Despensa",
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyThemeData.primaryColor,
        onPressed: () {
          String ruta = selectedIndex == 0 ? "/lista/add" : "/despensa/add";
          Get.toNamed(ruta);
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        heroTag: tag,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
