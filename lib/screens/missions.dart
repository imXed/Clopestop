import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MissionsPage extends StatefulWidget {
  const MissionsPage({Key? key}) : super(key: key);

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage> {
  int? dayswithoutS;
  int? minwithoutS;
  int? hoursswithoutS;

  String? txt = '';
  String? txt1 = '';

  String? txt2 = '';

  String? txt3 = '';

  String? txt4 = '';

  String? txt5 = '';

  String? txt6 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    minwithoutS = UserPrefs.getminWithoutSmoking();
    hoursswithoutS = UserPrefs.getHoursWithoutSmoking();
    dayswithoutS = UserPrefs.getDaysWithoutSmoking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Santé'),
        elevation: 0,
        backgroundColor: KPrimaryColor,
        leading: IconButton(
          onPressed: () {
            UserPrefs.setSigNotSmoked(0);
          },
          icon: const Icon(Icons.settings),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print(hoursswithoutS);
            },
            icon: const Icon(Icons.face),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '20 minutes apres la derniere cigarette :les pulsations du coeur ne sont plus perturbées ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (minwithoutS! >= 20) {
                            txt = 'atteinte';
                          } else {
                            txt = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: minwithoutS! >= 20 ? 1 : minwithoutS! / 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '8 heures apres la derniere cigarette :la quantite de monoxyde de carbone dans le sang diminue de moitie   ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (hoursswithoutS! >= 8) {
                            txt1 = 'atteinte';
                          } else {
                            txt1 = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: hoursswithoutS! >= 8 ? 1 : hoursswithoutS! / 8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt1!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '24 heures apres la derniere cigarette :le coprs ne contient plus de nicotine, elimine les toxines dans les pomons ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (hoursswithoutS! >= 24) {
                            txt2 = 'atteinte';
                          } else {
                            txt2 = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: hoursswithoutS! >= 24 ? 1 : hoursswithoutS! / 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt2!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '24 heures apres la derniere cigarette :le risque des maladie cardiaque diminue ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (hoursswithoutS! >= 24) {
                            txt3 = 'atteinte';
                          } else {
                            txt3 = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: hoursswithoutS! >= 24 ? 1 : hoursswithoutS! / 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt3!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '48 heures apres la derniere cigarette : le gout et l\'odorat s\'ameliorent ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (hoursswithoutS! >= 48) {
                            txt4 = 'atteinte';
                          } else {
                            txt4 = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: hoursswithoutS! >= 48 ? 1 : hoursswithoutS! / 48,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt4!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '48 heures apres la derniere cigarette :les terminaisons nerveuses endommagées commencent a repousser ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (hoursswithoutS! >= 48) {
                            txt5 = 'atteinte';
                          } else {
                            txt5 = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: hoursswithoutS! >= 48 ? 1 : hoursswithoutS! / 48,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt5!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '72 heures apres la derniere cigarette :respirer devient plus facile',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (hoursswithoutS! >= 72) {
                            txt6 = 'atteinte';
                          } else {
                            txt6 = 'en cours';
                          }
                        });
                      }),
                      barRadius: Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: hoursswithoutS! >= 72 ? 1 : hoursswithoutS! / 72,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt6!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 20),
              margin: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: KPrimaryColor, width: 2.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
