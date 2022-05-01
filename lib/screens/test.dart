import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUser(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          return ListView();
        },
      ),
    );
  }

  Stream<QuerySnapshot> getUser(BuildContext context) async* {
    final uid =
        await Provider.of<GoogleSignInProvider>(context, listen: false).getId();
    FirebaseFirestore.instance.collection("User").doc(uid).snapshots();
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var uid in querySnapshot.docs) {
        print(uid["name"]);
      }
    });
  }
}
