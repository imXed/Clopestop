import 'dart:convert';
import 'dart:math';

import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:clopestop/drawer.dart';
import 'package:clopestop/goals/goals_model.dart';
import 'package:clopestop/goals/goals_view.dart';
import 'package:clopestop/screens/home.dart';
import 'package:clopestop/the_game/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //goals declaraion
  SharedPreferences? pref;
  List goals = [];
  setupGoal() async {
    pref = await SharedPreferences.getInstance();
    String? stringGoal = pref?.getString('goal');
    List goalList = jsonDecode(stringGoal!);
    if (goalList != null) {
      for (var goal in goalList) {
        setState(() {
          goals.add(Goal().fromJson(goal));
        });
      }
    } else {}
  }

  void saveGoal() {
    List items = goals.map((e) => e.toJson()).toList();
    pref?.setString('goal', jsonEncode(items));
  }

  // goals
  final List<String> objectives = [];
  final textController = TextEditingController();
  String? date;
  int? cignotsmoked;
  String? name;
  int? cigusedtosmoke;
  int? cigAllowed;
  int? cigsmokedToday;
  int? daysdiff;
  int? day1;
  int? day2;
  int priceofcigaret = UserPrefs.getPrice()! ~/ UserPrefs.getSigInPacket()!;
  dynamic moneysaved;
  int price = UserPrefs.getPrice()!;
  int hourssaved = 0;
  int? dayssaved;
  int? minsaved;
  late String txt;
  late String txt1;
  int daysobj = 3;
  double? cigtoavoid;
  late int dayswithoutsmoking;
  int? moneyavailable;
  int? moneyspent;
  late int issmoking;
  int ok = 4;
  @override
  void initState() {
    // TODO: implement initState
    setupGoal();
    super.initState();

    setState(() {
      issmoking = UserPrefs.getIsSmoking()!;
      name = UserPrefs.getUsername() ?? '';
      cigusedtosmoke = UserPrefs.getSigPerDay() ?? 2;
      cigsmokedToday = UserPrefs.getSigSmoked();
      moneysaved = UserPrefs.getMoneySaved();
      cignotsmoked = UserPrefs.getSigNotSmoked();
      dayswithoutsmoking = UserPrefs.getDaysWithoutSmoking()!;
      moneyspent = UserPrefs.getMoneyspent();
      moneyavailable = moneysaved! - moneyspent;
      // initialising the sig allowed
      date = UserPrefs.getDate();
      // daysdiff = DateTime.now().difference(DateTime.parse(date!)).inDays;
      daysdiff = 0;
      /*  if (daysdiff! < 7 && daysdiff! >= 0) {
        cigAllowed = (cigusedtosmoke! ~/ 1.5);
      } else if (daysdiff! < 14 && daysdiff! >= 7) {
        cigAllowed = (cigusedtosmoke! ~/ 2);
      } else if (daysdiff! < 21 && daysdiff! >= 14) {
        cigAllowed = (cigusedtosmoke! ~/ 4);
      } else {
        cigAllowed = 2;
      } */

      if (daysdiff == 0) {
        cigtoavoid = (cigusedtosmoke! / daysobj);
        if (cigtoavoid! < 1) {
          cigAllowed = cigusedtosmoke! - 1;
        } else if (cigtoavoid! > 0) {
          cigAllowed = cigusedtosmoke! - (cigtoavoid! ~/ 1);
          UserPrefs.setCigAvoided(cigAllowed!);
        }
      } else if (daysdiff! + 1 < daysobj) {
        cigtoavoid = (cigusedtosmoke! / daysobj);
        cigAllowed = UserPrefs.getCigAvoided();
      } else if (daysdiff! + 1 > daysobj) {
        day1 = daysdiff! + 1;

        cigtoavoid = (cigusedtosmoke! / daysobj);
        cigAllowed = 0;
        dayswithoutsmoking = day1! - daysobj;

        UserPrefs.setDaysWithoutSmoking(dayswithoutsmoking);
      }

      if (issmoking == 1) {
        day1 = daysdiff! + 1;
        if (day1! <= daysobj) {
          txt = 'Jour $day1 sur $daysobj  ';
        } else {
          txt = '$day1   sans fumer';
        }
        txt1 = 'Cigarettes autorisées : $cigsmokedToday/$cigAllowed';
        day2 = UserPrefs.getDate2();
        // to update data every day
        if (day1 != day2) {
          moneysaved = moneysaved + (cigusedtosmoke! * priceofcigaret);
          moneyspent = UserPrefs.getMoneyspent();
          moneyavailable = moneysaved! - moneyspent;

          cignotsmoked = cignotsmoked! + cigusedtosmoke!;
          day2 = day1;
          cigsmokedToday = 0;
          UserPrefs.setSigSmoked(0);
          UserPrefs.setDate2(day2!);
          UserPrefs.setSigNotSmoked(cignotsmoked!);
          UserPrefs.setMoneySaved(moneysaved);
          if (daysdiff! > 0 && (daysdiff! + 1 < daysobj)) {
            cigAllowed = (cigAllowed! - cigtoavoid!) ~/ 1;
            UserPrefs.setCigAvoided(cigAllowed!);
          }

          if (day1! == daysobj) {
            cigAllowed = 0;
            UserPrefs.setCigAvoided(cigAllowed!);
            issmoking = 0;
            UserPrefs.setIsSmoking(issmoking);
            UserPrefs.setDate(DateTime.now().toString());
          }
        }
        // if the user is no longer smoking
      } else if (issmoking == 0) {
        if (daysdiff == 0) {
          UserPrefs.setMoneySpent(moneysaved);
          moneyavailable = 0;
        }
        cigAllowed = 0;
        day1 = daysdiff! + dayswithoutsmoking;

        dayswithoutsmoking = UserPrefs.getDaysWithoutSmoking()!;
        txt = '$day1  jours sans fumer';
        day1 = daysdiff! + dayswithoutsmoking;
        dayswithoutsmoking + 1;
        day2 = UserPrefs.getDate2();
        if (daysdiff! > 0 && day1 != day2) {
          UserPrefs.setDate2(daysdiff! + 1);
          print('not ok');
          dayswithoutsmoking + 1;
          moneysaved = moneysaved + (cigusedtosmoke! * priceofcigaret);
          moneyspent = UserPrefs.getMoneyspent();
          moneyavailable = moneysaved! - moneyspent;

          cignotsmoked = cignotsmoked! + cigusedtosmoke!;
          day2 = day1;
          UserPrefs.setSigSmoked(0);
          UserPrefs.setSigNotSmoked(cignotsmoked!);
          UserPrefs.setMoneySaved(moneysaved);
          UserPrefs.setDaysWithoutSmoking(dayswithoutsmoking);
          UserPrefs.setDate2(day2!);
        }
      }

      // life regained
      minsaved = cignotsmoked! * 11;
      while (minsaved! >= 60) {
        hourssaved = hourssaved + 1;
        minsaved = minsaved! - 60;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KPrimaryColor,
        title: IconButton(
          onPressed: () async {
            readUser();
            getName();
            /*  print('price of 1 is    $priceofcigaret');
            print('not smoked  $cignotsmoked');
            print(' smokedtoday is  $cigsmokedToday   ');
            print('day1 is $day');
            print('day2 is $day2');
            print('used to smoke is $cigusedtosmoke'); */
            print('$day1 > $day2');
            print(moneyavailable);
            print(moneyspent);
          },
          icon: const Icon(Icons.settings),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pop(context);
              int isViewed = 1;
              UserPrefs.setSignup(0);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('ShowMainScreen', isViewed);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));

              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
            },
            icon: const Icon(Icons.face),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: KPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            height: 200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      txt,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Cigarettes autorisées : $cigsmokedToday/$cigAllowed',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    if (issmoking == 1) {
                      setState(() {
                        cigsmokedToday = cigsmokedToday! + 1;
                        UserPrefs.setSigSmoked(cigsmokedToday!);
                        moneysaved = moneysaved - priceofcigaret;
                        moneysaved = moneysaved ~/ 1;
                        moneyavailable = moneyavailable! - priceofcigaret;
                        UserPrefs.setMoneySaved(moneysaved);
                        cignotsmoked = cignotsmoked! - 1;
                        UserPrefs.setSigNotSmoked(cignotsmoked!);
                        minsaved = minsaved! - 11;
                        while (minsaved! <= 0) {
                          hourssaved = hourssaved - 1;
                          minsaved = minsaved! + 60;
                          if (cigsmokedToday! > cigAllowed!) {
                            Distruction();
                          }
                        }
                      });
                    }
                    if (issmoking == 0) {
                      Distruction();

                      /* setState(() {
                        UserPrefs.setMoneySaved(0);
                        UserPrefs.setDate(DateTime.now().toString());
                        UserPrefs.setMoneySaved(0);
                        UserPrefs.setSigNotSmoked(0);
                        cignotsmoked = 0;
                        UserPrefs.setDaysWithoutSmoking(0);
                        UserPrefs.setHoursWithoutSmoking(0);
                        UserPrefs.setminWithoutSmoking(0);

                        UserPrefs.setDate(DateTime.now().toString());
                        date = UserPrefs.getDate();
                        daysdiff = DateTime.now()
                            .difference(DateTime.parse(date!))
                            .inDays;
                        day1 = daysdiff! + UserPrefs.getDaysWithoutSmoking()!;

                        moneysaved = 0;
                        day1 = 0;
                      }); */
                    }
                  },
                  child: Image.asset(
                    'assets/icons/smoke.png',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Dont give up  !',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 22),
                child: Text(
                  'Progression   ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Argnets économisés",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$moneysaved Dz",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 100,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Life regained",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$hourssaved h  $minsaved min",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 100,
              width: 370,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$cignotsmoked",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cigarettes non fumées",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            indent: 20,
            endIndent: 20,
            color: KPrimaryColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '    Objectifs à débloquer :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '  ' + moneyavailable.toString() + '    DZ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: goals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            elevation: 8.0,
                            child: Container(
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[400],
                                border: Border.all(
                                    color: KPrimaryColor, width: 2.5),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Goal t = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GoalView(goal: goals[index])));
                                  if (t != null) {
                                    setState(() {
                                      goals[index] = t;
                                    });
                                    saveGoal();
                                  }
                                },
                                child: makeListTile(goals[index], index),
                              ),
                            ));
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    addGoal();
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Center(
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 90),
                        ),
                      ),
                    ),
                    height: 100,
                    width: 370,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40)
        ],
      ),
    );
  }

  Future getInfos() async {
    List itemList = [];
    try {
      FirebaseFirestore.instance.collection('User').snapshots();
      FirebaseFirestore.instance.collection("User").get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
        print(itemList);
      });
    } catch (e) {
      print(e);
    }
    return itemList;
  }

  Future readUser() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    final docUser = FirebaseFirestore.instance.collection('User').doc(provider);
    final snapshot = await docUser.get();

    print(snapshot.data());
    return snapshot.data();
  }

  Future getName() async {
    final provider =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    DocumentSnapshot n1 =
        await FirebaseFirestore.instance.collection('User').doc(provider).get();
    print(n1['prix']);
  }

  getObj() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("objective"),
        content: Column(
          children: [
            TextField(controller: textController),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  objectives.add(textController.text);
                });
              },
              child: Icon(Icons.save),
            )
          ],
        ),
      ),
    );
  }

  addGoal() async {
    int id = Random().nextInt(30);
    Goal t = Goal(
      id: id,
      title: '',
      price: '',
    );
    Goal returnGoal = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => GoalView(goal: t)));
    if (returnGoal != null) {
      setState(() {
        goals.add(returnGoal);
      });
      saveGoal();
    }
  }

  makeListTile(Goal goal, index) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(
                width: 1.0,
                color: Colors.black,
              ),
            ),
          ),
          child: InkWell(
            onTap: () {
              Buy(goal);
            },
            child: Icon(Icons.local_grocery_store_outlined,
                color: KPrimaryColor, size: 30.0),
          )),
      title: Row(
        children: [
          Text(
            goal.title!,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      subtitle: Wrap(
        children: <Widget>[
          LinearPercentIndicator(
            leading: Text(
              '$moneyavailable',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              goal.price!,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            barRadius: Radius.circular(10),
            width: 120,
            lineHeight: 15,
            progressColor: KPrimaryColor,
            backgroundColor: Color.fromARGB(48, 73, 4, 233),
            animationDuration: 1500,
            animation: true,
            percent: (moneyavailable! / int.parse(goal.price!) > 1
                ? 1
                : moneyavailable! / int.parse(goal.price!)),
          ),
        ],
      ),
      trailing: InkWell(
          onTap: () {
            delete(goal);
          },
          child: Icon(Icons.delete, color: KPrimaryColor, size: 30.0)),
    );
  }

  delete(Goal goal) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Alert"),
              content: Text("Are you sure to delete"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("No")),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        goals.remove(goal);
                      });
                      Navigator.pop(ctx);
                      saveGoal();
                    },
                    child: Text("Yes"))
              ],
            ));
  }

  Buy(Goal goal) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text("avez-vous acheté cet article !"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("No")),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        if (moneyavailable! >= int.parse(goal.price!)) {
                          moneyavailable =
                              moneyavailable! - int.parse(goal.price!);
                          UserPrefs.setMoneySpent(
                              moneyspent! + int.parse(goal.price!));
                          goals.remove(goal);
                        } else if (moneyavailable! < int.parse(goal.price!)) {}
                      });
                      Navigator.pop(ctx);
                      saveGoal();
                    },
                    child: Text("Yes"))
              ],
            ));
  }

  Distruction() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Column(
                children: [
                  Text(
                    'Ne cede pas!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tiens bon',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Au lieu de fumer tu peux esseayer',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Container(
                height: 120.0,
                width: 400.0,
                child: Column(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => G1()),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 140,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Le Forum',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.chat,
                                  color: KPrimaryColor,
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              border:
                                  Border.all(color: KPrimaryColor, width: 2.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Jouer',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.games_outlined,
                                color: KPrimaryColor,
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            border:
                                Border.all(color: KPrimaryColor, width: 2.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                    onTap: (() {
                      setState(() {
                        moneysaved = 0;
                        UserPrefs.setMoneySaved(0);
                        UserPrefs.setDate(DateTime.now().toString());
                        cignotsmoked = 0;
                        UserPrefs.setSigNotSmoked(0);
                        day1 = 0;
                        UserPrefs.setDaysWithoutSmoking(0);
                        UserPrefs.setHoursWithoutSmoking(0);
                        UserPrefs.setminWithoutSmoking(0);

                        UserPrefs.setDate(DateTime.now().toString());
                        date = UserPrefs.getDate();
                        daysdiff = DateTime.now()
                            .difference(DateTime.parse(date!))
                            .inDays;
                        day1 = daysdiff! + UserPrefs.getDaysWithoutSmoking()!;
                        minsaved = 0;
                        hourssaved = 0;
                        moneyavailable = 0;
                        UserPrefs.setMoneySpent(0);
                      });
                    }),
                    child: Text(
                      'Fumer Quand meme',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )),
              ],
            ));
  }

  okk() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Text('Alert!'),
        );
      },
    );
  }
}
