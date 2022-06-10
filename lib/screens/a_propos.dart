import 'package:clopestop/consts.dart';
import 'package:flutter/material.dart';

class A_propos extends StatelessWidget {
  const A_propos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('à propos'),
        backgroundColor: KPrimaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            '"ClopeStop" votre accompagnant durant ce défi \n        pour arreter la cigarette definitivement.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto Condensed',
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          const Text(
            'Nous-contacter',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto Condensed',
            ),
          ),
          const Text(
            'Support@IWtech.dz',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const Text(
            '213+ 664184096',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Text(
            '038090907',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 300,
          ),
          const Text(
            '                             All copyrights reserved © 2022',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Roboto Condensed',
            ),
          ),
        ],
      ),
    );
  }
}
