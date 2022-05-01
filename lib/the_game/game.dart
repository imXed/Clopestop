import 'dart:async';

import 'package:clopestop/consts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class G1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<G1> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [
    'assets/icons/CSassets/horse.png',
    'assets/icons/CSassets/fox.png',
    'assets/icons/CSassets/hippo.png',
    'assets/icons/CSassets/panda.png',
    'assets/icons/CSassets/fox.png',
    'assets/icons/CSassets/horse.png',
    'assets/icons/CSassets/rabbit.png',
    'assets/icons/CSassets/panda.png',
    'assets/icons/CSassets/zoo.png',
    'assets/icons/CSassets/hippo.png',
    'assets/icons/CSassets/rabbit.png',
    'assets/icons/CSassets/zoo.png',
  ];
  int previousIndex = -1;
  bool flip = false;

  int time = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }

    startTimer();
    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KPrimaryColor,
        title: Text('The Game'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$time",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState!
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;
                              print(cardFlips);

                              if (cardFlips.every((t) => t == false)) {
                                print("Won");
                                showResult();
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        margin: const EdgeInsets.all(4.0),
                        color: KPrimaryColor.withOpacity(0.3),
                      ),
                      back: Container(
                        margin: const EdgeInsets.all(4.0),
                        color: Colors.white,
                        child: Center(
                          child: Image.asset(data[index]),
                        ),
                      ),
                    ),
                    itemCount: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Bien joué!!!"),
        content: Text(
          "Temps $time",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
