import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:flutter/material.dart';

class Trophys extends StatefulWidget {
  Trophys({Key? key}) : super(key: key);

  @override
  State<Trophys> createState() => _TrophysState();
}

class _TrophysState extends State<Trophys> {
  late String t1;
  late String t2;
  late String t3;

  late String t4;
  late String t5;
  late String t6;
  late String t7;
  late String t8;
  late String t9;
  late String t10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int cignotsmoked = UserPrefs.getSigNotSmoked()!;
    int dayswithoutsmoking = UserPrefs.getDaysWithoutSmoking()!;
    if (cignotsmoked < 20) {
      t1 = 'assets/icons/Trohpys/trophy20bw.png';
    } else {
      t1 = 'assets/icons/Trohpys/trophy20.png';
    }
    if (cignotsmoked < 50) {
      t2 = 'assets/icons/Trohpys/trophy50bw.png';
    } else {
      t2 = 'assets/icons/Trohpys/trophy50.png';
    }
    if (cignotsmoked < 100) {
      t3 = 'assets/icons/Trohpys/trophy100bw.png';
    } else {
      t3 = 'assets/icons/Trohpys/trophy100.png';
    }
    if (cignotsmoked < 500) {
      t4 = 'assets/icons/Trohpys/trophy500bw.png';
    } else {
      t4 = 'assets/icons/Trohpys/trophy500.png';
    }
    if (dayswithoutsmoking < 1) {
      t5 = 'assets/icons/Trohpys/d1bw.png';
    } else {
      t5 = 'assets/icons/Trohpys/trophyd1.png';
    }
    if (dayswithoutsmoking < 5) {
      t6 = 'assets/icons/Trohpys/d5bw.png';
    } else {
      t6 = 'assets/icons/Trohpys/trophyd5.png';
    }
    if (dayswithoutsmoking < 10) {
      t7 = 'assets/icons/Trohpys/d10bw.png';
    } else {
      t7 = 'assets/icons/Trohpys/trophyd10.png';
    }
    if (dayswithoutsmoking < 20) {
      t8 = 'assets/icons/Trohpys/d20bw.png';
    } else {
      t8 = 'assets/icons/Trohpys/trophyd20.png';
    }
    if (dayswithoutsmoking < 50) {
      t9 = 'assets/icons/Trohpys/d50bw.png';
    } else {
      t9 = 'assets/icons/Trohpys/trophyd50.png';
    }
    if (dayswithoutsmoking < 100) {
      t10 = 'assets/icons/Trohpys/d100bw.png';
    } else {
      t10 = 'assets/icons/Trohpys/trophyd100.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: Icon(
                Icons.settings,
              ),
              onTap: () {},
            )
          ],
          title: Text('Trophées'),
          backgroundColor: KPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Cigarettes non fumées',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      t1,
                      scale: 0.5,
                    ),
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      t2,
                      scale: 5,
                    ),
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      t3,
                      scale: 5,
                    ),
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      t4,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Jours sans fumer',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    child: Image.asset(
                      t5,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: Image.asset(
                      t6,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    child: Image.asset(
                      t7,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: Image.asset(
                      t8,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    child: Image.asset(
                      t9,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: Image.asset(
                      t10,
                      scale: 0.7,
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
}
