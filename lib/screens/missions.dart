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
  String? txt7 = '';

  String? txt8 = '';

  String? txt9 = '';
  String? txt10 = '';

  @override
  void initState() {
    // TODO: implement initState
    if (UserPrefs.getKey() == 1) {
      minwithoutS = UserPrefs.getminWithoutSmoking();
      hoursswithoutS = UserPrefs.getHoursWithoutSmoking();
      dayswithoutS = UserPrefs.getDaysWithoutSmoking();
    } else {
      if (UserPrefs.getOk() == 1) {
        print('0');
        minwithoutS = UserPrefs.getminWithoutSmoking();
        hoursswithoutS = UserPrefs.getHoursWithoutSmoking();
        dayswithoutS = UserPrefs.getDate2();
      }
      if (UserPrefs.getOk() == 0) {
        UserPrefs.setHoursWithoutSmoking(UserPrefs.getDate2()! * 24);
        UserPrefs.setminWithoutSmoking(
            UserPrefs.getHoursWithoutSmoking()! * 60);
        minwithoutS = UserPrefs.getminWithoutSmoking();
        hoursswithoutS = UserPrefs.getHoursWithoutSmoking();
        dayswithoutS = UserPrefs.getDate2();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('       Santé'),
        elevation: 0,
        backgroundColor: KPrimaryColor,
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
                    'Les pulsations du coeur ne sont plus\n                    perturbées ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   20 min',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'La pression sanguine n\'est plus perturbé',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   20 min',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'La quantité de monoxyde de carbone dans\n              le sang diminue de moitié   ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   8 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'L\'oxygénation des cellules redevient\n                           normale',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   8 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le coprs ne contient plus de nicotine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   24 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le risque des maladie cardiaque diminue ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   24 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le goût et l\'odorat s\'ameliorent ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   48 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Les terminaisons nerveuses endommagées\n              commencent à repousser ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   48 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'La nicotine et ses métabolite sont complètement\n                       éliminés de l\'organisme ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   48 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Respirer devient plus facile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   72 heures',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      barRadius: const Radius.circular(10),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Le risque d\'infractus a diminiuer ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   2 semaines',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 14) {
                            txt7 = 'atteinte';
                          } else {
                            txt7 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 14 ? 1 : dayswithoutS! / 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt7!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'La coagulation s\'est normalisée ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '   2 semaines',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 14) {
                            txt7 = 'atteinte';
                          } else {
                            txt7 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 14 ? 1 : dayswithoutS! / 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt7!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le risque de développer des maladies\n        cardiovasculaires a diminué ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '  1 mois',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 30) {
                            txt8 = 'atteinte';
                          } else {
                            txt8 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 30 ? 1 : dayswithoutS! / 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt8!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le risque de développer un diabète type 2 \n                            a diminué ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '  1 mois',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 30) {
                            txt8 = 'atteinte';
                          } else {
                            txt8 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 30 ? 1 : dayswithoutS! / 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt8!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le risque de développer un cancer\n                      a diminué ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '  1 mois',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 30) {
                            txt8 = 'atteinte';
                          } else {
                            txt8 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 30 ? 1 : dayswithoutS! / 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt8!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'La toux et la fatigue  diminuent ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '  3 mois',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 90) {
                            txt9 = 'atteinte';
                          } else {
                            txt9 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 90 ? 1 : dayswithoutS! / 90,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt9!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'On récupère du souffle et on marche \n                  plus facilement',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '  3 mois',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 90) {
                            txt9 = 'atteinte';
                          } else {
                            txt9 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 90 ? 1 : dayswithoutS! / 90,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt9!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                    'Le risqaue de maladie cardiaque réduit à 50%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.smoke_free),
                      Text(
                        '  1 an',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto Condensed',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: LinearPercentIndicator(
                      onAnimationEnd: (() {
                        setState(() {
                          if (dayswithoutS! >= 365) {
                            txt10 = 'atteinte';
                          } else {
                            txt10 = 'en cours';
                          }
                        });
                      }),
                      barRadius: const Radius.circular(10),
                      width: 250,
                      lineHeight: 15,
                      progressColor: KPrimaryColor,
                      animationDuration: 1500,
                      animation: true,
                      percent: dayswithoutS! >= 365 ? 1 : dayswithoutS! / 365,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    txt10!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
