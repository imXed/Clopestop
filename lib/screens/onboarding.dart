import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:clopestop/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/google_sign_in.dart';

class OnboardingPAge extends StatefulWidget {
  @override
  State<OnboardingPAge> createState() => _OnboardingPAgeState();
}

class _OnboardingPAgeState extends State<OnboardingPAge> {
  bool isVisible = false;
  int? fuming;
  Color color1 = Colors.white;
  Color color2 = Colors.white;

  final text1 = TextEditingController();
  bool _validate1 = false;
  final text2 = TextEditingController();
  bool _validate2 = false;

  final text3 = TextEditingController();
  bool _validate3 = false;

  final text4 = TextEditingController();
  bool _validate4 = false;
  final text5 = TextEditingController();
  bool _validate5 = false;

  String txt = '';
  String txt1 = 'Objectif';
  String txt2 = 'jours sans fumer';
  @override
  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ShowMainScreen', isViewed);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        showNextButton: false,
        onDone: () async {
          setState(() {
            text1.text.isEmpty ? _validate1 = true : _validate1 = false;

            text2.text.isEmpty ? _validate2 = true : _validate2 = false;
            text3.text.isEmpty ? _validate3 = true : _validate3 = false;
            text4.text.isEmpty ? _validate4 = true : _validate4 = false;
            text5.text.isEmpty ? _validate5 = true : _validate5 = false;
          });
          if (text2.text.isNotEmpty &&
              text1.text.isNotEmpty &&
              text3.text.isNotEmpty &&
              text4.text.isNotEmpty &&
              isVisible == false) {
            await UserPrefs.setMoneySpent(0);

            await _storeOnBoardInfo();
            await UserPrefs.setSigSmoked(0);
            await UserPrefs.setDate(DateTime.now().toString());
            await UserPrefs.setMoneySaved(0);
            await UserPrefs.setDate2(0);
            await UserPrefs.setSigNotSmoked(0);
            await UserPrefs.setMoneySaved(0);
            await UserPrefs.setDate2(-1);
            await UserPrefs.setSigNotSmoked(0);
            await UserPrefs.setMoneySpent(0);
            SharedPreferences pref = await SharedPreferences.getInstance();

            setState(() {
              List items = [];

              pref.setString('goal', jsonEncode(items));
            });
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const MainScreen();
            }));
          } else if (text2.text.isNotEmpty &&
              text1.text.isNotEmpty &&
              text3.text.isNotEmpty &&
              text4.text.isNotEmpty &&
              (isVisible == true) &&
              text5.text.isNotEmpty) {
            int money = ((UserPrefs.getSigPerDay() as int) *
                (UserPrefs.getDaysWithoutSmoking() as int) *
                (UserPrefs.getPrice()! ~/ UserPrefs.getSigInPacket()!));
            await _storeOnBoardInfo();
            await UserPrefs.setSigSmoked(0);
            await UserPrefs.setDate(DateTime.now().toString());
            await UserPrefs.setMoneySaved(money);
            await UserPrefs.setDate2(0);
            await UserPrefs.setSigNotSmoked((UserPrefs.getSigPerDay() as int) *
                (UserPrefs.getDaysWithoutSmoking() as int));

            SharedPreferences pref = await SharedPreferences.getInstance();

            setState(() {
              List items = [];

              pref.setString('goal', jsonEncode(items));
            });
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const MainScreen();
            }));
          }
        },
        globalBackgroundColor: Color.fromARGB(255, 95, 81, 179),
        animationDuration: 500,
        dotsDecorator: DotsDecorator(
          activeColor: Colors.white,
          size: const Size(10, 10),
          activeSize: const Size(20, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        pages: [
          PageViewModel(
            decoration: PageDecoration(
                boxDecoration: BoxDecoration(
                    image: new DecorationImage(
              image: new AssetImage("assets/icons/background.png"),
              fit: BoxFit.fill,
            ))),
            bodyWidget: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Tout d\'abord, quel est ton  ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(' Prénom ? ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            titleWidget: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'assets/icons/name.png',
                  scale: 5,
                ),
              ],
            ),
            footer: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: text1,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  onChanged: (data) async {
                    // saving data in Firebase
                    final String username = data;
                    final provider = await Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false)
                        .getId();
                    FirebaseFirestore.instance
                        .collection("User")
                        .doc(provider)
                        .update({
                      'name': username,
                    });
                    //
                    await UserPrefs.setUsername(data);
                  },
                  decoration: (InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorText: _validate1 ? 'Champ obligatoire' : null,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KPrimaryColor,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
          PageViewModel(
              decoration: PageDecoration(
                  boxDecoration: BoxDecoration(
                      image: new DecorationImage(
                image: new AssetImage("assets/icons/background.png"),
                fit: BoxFit.fill,
              ))),
              titleWidget: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text('Je suis un(e)  ',
                      style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              bodyWidget: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = false;
                            UserPrefs.setIsSmoking(1);
                            txt = txt1;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/smoker.png',
                              scale: 5,
                            ),
                            Text('fumer actif ',
                                style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                          height: 150,
                          child: VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          )),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = true;
                            UserPrefs.setIsSmoking(0);
                            txt = txt2;
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/icons/notsmoker.png',
                              scale: 5,
                            ),
                            Text('Ex-fumeur ',
                                style: TextStyle(
                                    fontFamily: 'Roboto Condensed',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              footer: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Text(txt,
                            style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: text5,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (data) async {
                            UserPrefs.setDaysWithoutSmoking(int.parse(data));
                            UserPrefs.setHoursWithoutSmoking(
                                UserPrefs.getDaysWithoutSmoking()! * 24);
                            UserPrefs.setminWithoutSmoking(
                                UserPrefs.getHoursWithoutSmoking()! * 60);
                            print(data);
                          },
                          decoration: (InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            errorText: (_validate5 && isVisible == true)
                                ? 'Champ obligatoire'
                                : null,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: KPrimaryColor,
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          PageViewModel(
            decoration: PageDecoration(
                boxDecoration: BoxDecoration(
                    image: new DecorationImage(
              image: new AssetImage("assets/icons/background.png"),
              fit: BoxFit.fill,
            ))),
            bodyWidget: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(' Combien de cigarettes ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(' fumez vous par jour ? ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            titleWidget: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'assets/icons/cigperday.png',
                  scale: 6,
                ),
              ],
            ),
            footer: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: text2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (data) async {
                    final provider = await Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false)
                        .getId();
                    int cigparjour = int.parse(data);
                    FirebaseFirestore.instance
                        .collection("User")
                        .doc(provider)
                        .update({
                      'cigparjour': cigparjour,
                    });
                    await UserPrefs.setSigPerDay(int.parse(data));
                  },
                  decoration: (InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorText: _validate2 ? 'Champ obligatoire' : null,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              ],
            ),
          ),
          PageViewModel(
            decoration: PageDecoration(
                boxDecoration: BoxDecoration(
                    image: new DecorationImage(
              image: new AssetImage("assets/icons/background.png"),
              fit: BoxFit.fill,
            ))),
            bodyWidget: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(' Combien y a t’il de ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(' cigarettes par paquet ?',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            titleWidget: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'assets/icons/paquet.png',
                  scale: 6,
                ),
              ],
            ),
            footer: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: text3,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (data) async {
                    final provider = await Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false)
                        .getId();

                    int cigpacket = int.parse(data);
                    FirebaseFirestore.instance
                        .collection("User")
                        .doc(provider)
                        .update({
                      'cigpacket': cigpacket,
                    });
                    await UserPrefs.setSigInPacket(int.parse(data));
                  },
                  decoration: (InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorText: _validate3 ? 'Champ obligatoire' : null,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KPrimaryColor,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
          PageViewModel(
            decoration: PageDecoration(
                boxDecoration: BoxDecoration(
                    image: new DecorationImage(
              image: new AssetImage("assets/icons/background.png"),
              fit: BoxFit.fill,
            ))),
            bodyWidget: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(' Combien vous coûte un  ',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(' paquet de cigarettes ?',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            titleWidget: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'assets/icons/packetprice.png',
                  scale: 6,
                ),
              ],
            ),
            footer: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: text4,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (data) async {
                    final provider = await Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false)
                        .getId();
                    int prixpacket = int.parse(data);
                    FirebaseFirestore.instance
                        .collection("User")
                        .doc(provider)
                        .update({
                      'prix': prixpacket,
                    });
                    await UserPrefs.setPrice(int.parse(data));
                  },
                  decoration: (InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorText: _validate4 ? 'Champ obligatoire' : null,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: KPrimaryColor,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
        done: const Text(
          'Next ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
