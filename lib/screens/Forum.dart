import 'package:clopestop/consts.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_Bubles.dart';

class Forum extends StatelessWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor,
          title: Text('The Chat'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return chat_Buble();
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Aa',
                    suffixIcon: Icon(
                      Icons.send,
                      color: KPrimaryColor,
                      size: 35,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: KPrimaryColor),
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
          ],
        ));
  }
}
