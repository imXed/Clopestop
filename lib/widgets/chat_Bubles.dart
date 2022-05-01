import 'package:flutter/material.dart';
import 'package:clopestop/consts.dart';

class chat_Buble extends StatelessWidget {
  const chat_Buble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 20),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: KPrimaryColor,
        ),
        child: Text(
          'hello',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
