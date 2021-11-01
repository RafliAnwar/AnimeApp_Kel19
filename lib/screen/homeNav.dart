import 'package:flutter/material.dart';
import 'package:modul3_kel19/screen/home.dart';
import 'package:modul3_kel19/screen/kelompok.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    KelompokPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 20), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 20), label: 'Profile'),
          ],
          selectedItemColor: Colors.amber ,
          elevation: 5.0,
          unselectedItemColor: Color(0xff063970),
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
