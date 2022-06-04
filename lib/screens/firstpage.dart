import 'dart:convert';
import 'dart:math';

import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:clopestop/drawer.dart';
import 'package:clopestop/goals/goals_model.dart';
import 'package:clopestop/goals/goals_view.dart';
import 'package:clopestop/screens/missions.dart';
import 'package:clopestop/the_game/game.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';

import '../Forum/Forum.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Motivation
  List<String> Motiv = [
    'Ne lache pas! Tu y presque ',
    'Courage! Sois plus fort que l\'envie',
    'Pense a ton objectif',
    'Rappel toi la promess que tu t\'es fait',
  ];
  String? Moativa;

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

  // confetti animation (felicitation animation)
  bool play = false;
  final controller = ConfettiController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final itemKey = GlobalKey();
  final itemKey1 = GlobalKey();

  final List<String> objectives = [];
  final textController = TextEditingController();
  String? date;
  int? cignotsmoked;
  String? name;
  int? cigusedtosmoke;
  int? cigAllowed;
  int? cigsmokedToday;
  int? daysdiff;
  int? mindiff;
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
  int? daysobj;
  double? cigtoavoid;
  late int dayswithoutsmoking;
  int? minwithoutS;
  int? moneyavailable;
  int? moneyspent;
  late int issmoking;
  int ok = 4;
  @override
  void initState() {
    Moativa = (Motiv.toList()..shuffle()).first;
    // TODO: implement initState
    setupGoal();
    super.initState();

    setState(() {
      daysobj = UserPrefs.getDaysObj();
      issmoking = UserPrefs.getIsSmoking()!;
      name = UserPrefs.getUsername() ?? '';
      cigusedtosmoke = UserPrefs.getSigPerDay() ?? 2;
      cigsmokedToday = UserPrefs.getSigSmoked();
      moneysaved = UserPrefs.getMoneySaved();
      cignotsmoked = UserPrefs.getSigNotSmoked();
      dayswithoutsmoking = UserPrefs.getDaysWithoutSmoking()!;
      moneyspent = UserPrefs.getMoneyspent();
      moneyavailable = moneysaved! - moneyspent;
      date = UserPrefs.getDate();
      daysdiff = DateTime.now().difference(DateTime.parse(date!)).inHours;
      mindiff = DateTime.now().difference(DateTime.parse(date!)).inMinutes;
      minwithoutS = UserPrefs.getminWithoutSmoking();

      if (daysdiff == 0) {
        cigtoavoid = (cigusedtosmoke! / daysobj!);
        if (cigtoavoid! < 1) {
          cigAllowed = cigusedtosmoke! - 1;
        } else if (cigtoavoid! > 0) {
          cigAllowed = cigusedtosmoke! - (cigtoavoid! ~/ 1);
          UserPrefs.setCigAvoided(cigAllowed!);
        }
      } else if (daysdiff! + 1 < daysobj!) {
        cigtoavoid = (cigusedtosmoke! / daysobj!);
        cigAllowed = UserPrefs.getCigAvoided();
      } else if ((daysdiff! + 1 > daysobj!) && UserPrefs.getKey() == 1) {
        day1 = daysdiff! + 1;

        cigtoavoid = (cigusedtosmoke! / daysobj!);
        cigAllowed = 0;
        dayswithoutsmoking = day1! - daysobj!;
        UserPrefs.setDaysWithoutSmoking(dayswithoutsmoking);
      }
      // if he still smoking
      if (issmoking == 1) {
        day1 = daysdiff! + 1;
        if (day1! <= daysobj!) {
          txt = 'Jour $day1 sur $daysobj  ';
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
          if (daysdiff! > 0 && (daysdiff! + 1 < daysobj!)) {
            cigAllowed = (cigAllowed! - cigtoavoid!) ~/ 1;
            UserPrefs.setCigAvoided(cigAllowed!);
          }

          if (day1! >= daysobj!) {
            cigAllowed = 0;
            UserPrefs.setCigAvoided(cigAllowed!);
            issmoking = 0;
            UserPrefs.setIsSmoking(issmoking);
            UserPrefs.setDate(DateTime.now().toString());
            controller.play();
          }
        }
        // if the user is no longer smoking
      } else if (issmoking == 0) {
        if (UserPrefs.getKey() == 0) {
          day1 = daysdiff! + dayswithoutsmoking;
          txt = '$day1 jours sans fumer';

          if (daysdiff == 0) {
            setState(() {
              moneyavailable = 0;
            });
            UserPrefs.setDate2(dayswithoutsmoking);
            UserPrefs.setMoneySpent(moneysaved);
          }
        }

        cigAllowed = 0;
        if (UserPrefs.getKey() == 1) {
          if (daysdiff == 0 && UserPrefs.getOk() == 0) {
            txt = 'Jour $daysobj sur $daysobj  ';
          } else if (daysdiff! > 0 && UserPrefs.getOk() == 0) {
            day1 = daysdiff! - UserPrefs.getOk()!;
            UserPrefs.setDaysWithoutSmoking(day1!);
            UserPrefs.setminWithoutSmoking(mindiff!);

            txt = '$day1 jours sans fumer';
          } else if (UserPrefs.getOk() == 1) {
            day1 = daysdiff! + 1 - UserPrefs.getOk()!;
            UserPrefs.setDaysWithoutSmoking(day1!);
            UserPrefs.setminWithoutSmoking(mindiff!);

            txt = '$day1 jours sans fumer';
          }
        }

        day2 = UserPrefs.getDate2();

        if (daysdiff! >= 1 && day1 != day2 && UserPrefs.getKey() == 0) {
          setState(() {
            moneysaved = UserPrefs.getMoneySaved()! +
                (day1! - day2!) * (cigusedtosmoke! * priceofcigaret);
            moneyspent = UserPrefs.getMoneyspent();
            moneyavailable = moneysaved! - moneyspent;

            cignotsmoked = cignotsmoked! + (day1! - day2!) * cigusedtosmoke!;
            UserPrefs.setSigSmoked(0);
            UserPrefs.setSigNotSmoked(cignotsmoked!);
            UserPrefs.setMoneySaved(moneysaved);
          });
          UserPrefs.setDate2(day1!);
        }
        if (daysdiff! > 0 && day1 != day2 && UserPrefs.getKey() == 1) {
          controller.stop();

          setState(() {
            if ((day1! - day2!) > 1) {
              moneysaved = moneysaved +
                  (day1! - day2!) * (cigusedtosmoke! * priceofcigaret);
              moneyspent = UserPrefs.getMoneyspent();
              moneyavailable = moneysaved! - moneyspent;

              cignotsmoked = cignotsmoked! + (day1! - day2!) * cigusedtosmoke!;
            } else {
              moneysaved = moneysaved + (cigusedtosmoke! * priceofcigaret);
              moneyspent = UserPrefs.getMoneyspent();
              moneyavailable = moneysaved! - moneyspent;

              cignotsmoked = cignotsmoked! + cigusedtosmoke!;
            }

            UserPrefs.setSigSmoked(0);
            UserPrefs.setSigNotSmoked(cignotsmoked!);
            UserPrefs.setMoneySaved(moneysaved);
          });
          UserPrefs.setDate2(day1!);
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
    return WillPopScope(
      onWillPop: () async {
        {}
        return false;
      },
      child: Scaffold(
        extendBody: true,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: KPrimaryColor,
        ),
        body: Stack(children: [
          ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: KPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                height: 220,
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
                          style: const TextStyle(
                              fontFamily: 'Roboto Condensed',
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Cigarettes autorisées : $cigsmokedToday/$cigAllowed',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (issmoking == 1) {
                          if (cigsmokedToday! < cigAllowed!) {
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
                              }
                            });
                          } else if (cigsmokedToday! >= cigAllowed!) {
                            Distruction();
                          }
                        }
                        if (issmoking == 0) {
                          Distruction();
                        }
                      },
                      child: Image.asset(
                        'assets/icons/cendrier.png',
                        scale: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Moativa!,
                      style: const TextStyle(
                          fontFamily: 'Roboto Condensed',
                          color: Colors.white,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 22),
                    child: Text(
                      'Progression   ',
                      style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final context = itemKey.currentContext!;
                        await Scrollable.ensureVisible(context);
                      },
                      child: Container(
                        height: 100,
                        width: 180,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: KPrimaryColor, width: 2.5),
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                SizedBox(width: 5),
                                Icon(
                                  Icons.attach_money_outlined,
                                  color: KPrimaryColor,
                                ),
                                Text(
                                  "  Argnet économisé",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "$moneysaved Dz",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final context1 = itemKey1.currentContext;
                        await Scrollable.ensureVisible(context1!);
                      },
                      child: Container(
                        height: 100,
                        width: 180,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: KPrimaryColor, width: 2.5),
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.hourglass_bottom_rounded,
                                  color: KPrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Temps de vie\n     gagné",
                                  style: TextStyle(
                                      fontFamily: 'Roboto Condensed',
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "$hourssaved h  $minsaved min",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 100,
                  width: 370,
                  decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            Icons.smoke_free,
                            color: KPrimaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Cigarettes non fumées ",
                            style: TextStyle(
                                fontFamily: 'Roboto Condensed',
                                color: Colors.black,
                                fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$cignotsmoked",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
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
              Container(
                key: itemKey1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 22),
                      child: Text(
                        'Etat de santé   ',
                        style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Pulsations\n  du coeur',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Roboto Condensed',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/icons/pulsation.png',
                          scale: 18,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          barRadius: const Radius.circular(10),
                          width: 80,
                          lineHeight: 10,
                          progressColor: KPrimaryColor,
                          animationDuration: 1500,
                          animation: true,
                          percent: minwithoutS! >= 20 ? 1 : minwithoutS! / 20,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Recuperation\n   du souffle',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Roboto Condensed',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/icons/souffle.png',
                          scale: 18,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          barRadius: const Radius.circular(10),
                          width: 80,
                          lineHeight: 10,
                          progressColor: KPrimaryColor,
                          animationDuration: 1500,
                          animation: true,
                          percent: minwithoutS! >= 20 ? 1 : minwithoutS! / 20,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MissionsPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 52,
                          ),
                          Text(
                            '  Details...  ',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Roboto Condensed',
                            ),
                          ),
                          SizedBox(height: 52),
                        ],
                      ),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: KPrimaryColor, width: 2.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
                color: KPrimaryColor,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      key: itemKey,
                      child: Row(
                        children: [
                          const Text(
                            '    Objectifs à débloquer :',
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '  ' + moneyavailable.toString() + '    DZ',
                            style: const TextStyle(
                              fontFamily: 'Roboto Condensed',
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: goals.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 8.0,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 7),
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
                                              builder: (context) => GoalView(
                                                  goal: goals[index])));
                                      setState(() {
                                        goals[index] = t;
                                      });
                                      saveGoal();
                                    },
                                    child: makeListTile(goals[index], index),
                                  ),
                                ));
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        addGoal();
                      },
                      child: Container(
                        child: const Padding(
                          padding: EdgeInsets.only(left: 25),
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
                            border:
                                Border.all(color: KPrimaryColor, width: 2.5),
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
          ConfettiWidget(
              confettiController: controller,
              shouldLoop: true,
              blastDirection: 0,
              emissionFrequency: 0.10)
        ]),
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
    setState(() {
      goals.add(returnGoal);
    });
    saveGoal();
  }

  makeListTile(Goal goal, index) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1.0,
                color: Colors.black,
              ),
            ),
          ),
          child: InkWell(
            onTap: () {
              Buy(goal);
            },
            child: const Icon(Icons.local_grocery_store_outlined,
                color: KPrimaryColor, size: 30.0),
          )),
      title: Row(
        children: [
          Text(
            goal.title!,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      subtitle: Wrap(
        children: <Widget>[
          LinearPercentIndicator(
            leading: Text(
              '$moneyavailable',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              goal.price!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            barRadius: const Radius.circular(10),
            width: 120,
            lineHeight: 15,
            progressColor: KPrimaryColor,
            backgroundColor: const Color.fromARGB(48, 73, 4, 233),
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
          child: const Icon(Icons.delete, color: KPrimaryColor, size: 30.0)),
    );
  }

  delete(Goal goal) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Alert"),
              content: const Text("Are you sure to delete"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("No")),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        goals.remove(goal);
                      });
                      Navigator.pop(ctx);
                      saveGoal();
                    },
                    child: const Text("Yes"))
              ],
            ));
  }

  Buy(Goal goal) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: const Text("avez-vous acheté cet article !"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("No")),
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
                    child: const Text("Yes"))
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
                children: const [
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
              content: SizedBox(
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
                              children: const [
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
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Forum()),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Forum',
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
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if ((UserPrefs.getKey() == 1) &&
                        (UserPrefs.getIsSmoking() == 1) &&
                        (UserPrefs.getSigPerDay()! >
                            UserPrefs.getSigSmoked()!)) {
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
                        }
                      });
                    } else if (issmoking == 0) {
                      setState(() {
                        moneysaved = 0;
                        UserPrefs.setMoneySaved(0);
                        UserPrefs.setDate(DateTime.now().toString());
                        cignotsmoked = 0;
                        UserPrefs.setSigNotSmoked(0);

                        UserPrefs.setDaysWithoutSmoking(0);
                        UserPrefs.setHoursWithoutSmoking(0);
                        UserPrefs.setminWithoutSmoking(0);
                        UserPrefs.setDate2(0);
                        date = UserPrefs.getDate();
                        daysdiff = DateTime.now()
                            .difference(DateTime.parse(date!))
                            .inDays;

                        day1 = 0;
                        moneyavailable = 0;
                        UserPrefs.setMoneySpent(0);
                        UserPrefs.setOk(1);
                        txt = '0 jours sans fumer';
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Fumer Quand meme',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ));
  }
}
