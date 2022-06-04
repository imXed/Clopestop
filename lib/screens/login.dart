import 'package:clopestop/delayed.dart';
import 'package:clopestop/consts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/icons/background.png"))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              const Delayed_A(
                delay: 1000,
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'ClopeStop',
                        style: TextStyle(
                            fontFamily: 'Roboto Condensed',
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Delayed_A(
                delay: 2000,
                child: Center(
                  child: Image.asset(
                    'assets/icons/login_Icon.png',
                    scale: 1.5,
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              Delayed_A(
                delay: 3000,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Il n\'est ',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontFamily: 'Roboto Condensed',
                      ),
                    ),
                    Text(
                      'jamais trop tard ',
                      style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 24,
                          color: Color.fromARGB(255, 124, 12, 79)),
                    ),
                  ],
                ),
              ),
              const Delayed_A(
                delay: 3000,
                child: Center(
                  child: Text(
                    'pour arreter une mauvaise habitude',
                    style: TextStyle(
                      fontSize: 23,
                      color: (Colors.white),
                      fontFamily: 'Roboto Condensed',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              Delayed_A(
                delay: 3500,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 90),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: 50,
                  child: GestureDetector(
                    onTap: () async {
                      await Provider.of<GoogleSignInProvider>(context,
                              listen: false)
                          .GoogleLogin();
                    },
                    child: Center(
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 63,
                          ),
                          Text(
                            'S\'inscrire',
                            style: TextStyle(
                              fontFamily: 'Roboto Condensed',
                              color: KPrimaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Delayed_A(
                delay: 3500,
                child: Center(
                  child: Text(
                    'J\'ai deja un compte',
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        color: Colors.white,
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
