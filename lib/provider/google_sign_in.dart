import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future GoogleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) => {
                FirebaseFirestore.instance
                    .collection('User')
                    .doc(value.user?.uid)
                    .set({
                  'email': value.user?.email,
                })
              });
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<String> getId() async {
    String uid = (_firebaseAuth.currentUser!.uid);
    print(uid);
    return uid;
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
