import 'package:clopestop/Forum/Forum.dart';
import 'package:clopestop/screens/firstpage.dart';
import 'package:clopestop/screens/missions.dart';
import 'package:clopestop/screens/trophys.dart';
import 'package:clopestop/the_game/game.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  final String? user;
  final String? prix;
  final String? cigperday;
  final String? cigpacket;

  const MainScreen({this.user, this.cigpacket, this.cigperday, this.prix});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 2;
  final screens = [const Trophys(), const MissionsPage(), const Home(), const Forum(), G1()];
  final items = <Widget>[
    Image.asset(
      'assets/icons/medal.png',
    ),
    Image.asset(
      'assets/icons/heart-attack.png',
      scale: 1.1,
    ),
    const Icon(
      Icons.home,
      size: 30,
    ),
    Image.asset(
      'assets/icons/discussion.png',
      scale: 1.1,
    ),
    Image.asset(
      'assets/icons/console.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String? nom = widget.user;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: (const Color.fromARGB(255, 102, 103, 171)),
        backgroundColor: Colors.transparent,
        height: 50,
        items: items,
        index: 2,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: screens[selectedIndex],
    );
  }
}
