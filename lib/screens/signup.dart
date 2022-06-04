import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class SignUpWelcome extends StatefulWidget {
  const SignUpWelcome({Key? key}) : super(key: key);

  @override
  State<SignUpWelcome> createState() => _SignUpWelcomeState();
}

class _SignUpWelcomeState extends State<SignUpWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          IconButton(
              onPressed: () {
                Provider.of<GoogleSignInProvider>(context, listen: false)
                    .logout();
              },
              icon: const Icon(Icons.account_balance_outlined)),
        ],
      ),
    );
  }
}
