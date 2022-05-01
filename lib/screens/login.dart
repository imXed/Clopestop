import 'dart:convert';
import 'dart:math';
import 'package:clopestop/UserPrefs.dart';

import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:clopestop/drawer.dart';
import 'package:clopestop/goals/goals_model.dart';
import 'package:clopestop/goals/goals_view.dart';
import 'package:clopestop/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/google_sign_in.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    late String name;
    late String date;
    late int moneysaved;
    late int cigusedtosmoke;
    late int ciginpacket;
    late int price;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/icons/primicon.png',
                ),
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            const Center(
              child: Text(
                'Félicitations !',
                style: TextStyle(color: KPrimaryColor, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'Tu viens juste de faire le premier pas',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Center(
              child: Text(
                'pour quitter la cigarette',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: KPrimaryColor,
              ),
              padding: const EdgeInsets.only(left: 24),
              alignment: Alignment.centerLeft,
              height: 60,
              width: double.infinity,
              child: GestureDetector(
                onTap: () async {
                  await Provider.of<GoogleSignInProvider>(context,
                          listen: false)
                      .GoogleLogin();
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/google.png',
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      'Sign up with google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Text('Allready have an account ?'),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<GoogleSignInProvider>(context, listen: false)
                        .GoogleLogin();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: KPrimaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String> getName() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    return (n1['name']).toString();
  }

  Future<String> getDate() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    return (n1['date']).toString();
  }

  Future<int> getPrice() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    return int.parse(n1['prix']);
  }

  Future<int> getMoneySaved() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    return int.parse(n1['argenteco']);
  }

  Future<int> getcigpacket() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    return int.parse(n1['cigpacket']);
  }

  Future<int> getCig() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    return int.parse(n1['cigparjour']);
  }
}

/*
name = await getName();
                  UserPrefs.setUsername(name);
                  date = await getDate();
                  UserPrefs.setDate(date);
                  price = await getPrice();
                  UserPrefs.setPrice(price);
                  ciginpacket = await getPrice();
                  UserPrefs.setPrice(ciginpacket);
                  cigusedtosmoke = await getPrice();
                  UserPrefs.setPrice(cigusedtosmoke);
                  moneysaved = await getPrice();
                  UserPrefs.setPrice(moneysaved);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainScreen()));
                      */