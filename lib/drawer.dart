import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:clopestop/provider/google_sign_in.dart';
import 'package:clopestop/screens/a_propos.dart';
import 'package:clopestop/screens/home.dart';
import 'package:clopestop/screens/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: KPrimaryColor,
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/icons/user.png',
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text('Hello',
                      style: TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(UserPrefs.getUsername()!,
                      style: const TextStyle(
                          fontFamily: 'Roboto Condensed',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
                text: ' renitilialiser',
                icon: Icons.event_repeat,
                onClicked: () => selectedItem(context, 1)),
            const SizedBox(
              height: 20,
            ),
            MenuItem(
                text: ' à propos ',
                icon: Icons.phone_android,
                onClicked: () => selectedItem(context, 3)),
            const SizedBox(
              height: 20,
            ),
            MenuItem(
                text: ' Log out',
                icon: Icons.login_outlined,
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 220,
            ),
            MenuItem(text: ' version : 1.0.0 ', icon: Icons.system_update_alt),
          ],
        ),
      ),
    );
  }

  Header({required String names, required String dates}) {
    ListTile(
      title: Column(
        children: [
          Text(names),
          Text(dates),
        ],
      ),
    );
  }

  MenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      case 1:
        {
          UserPrefs.setMoneySpent(0);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return OnboardingPAge();
          }));
        }
    }
    switch (index) {
      case 2:
        {
          int isViewed = 1;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('ShowMainScreen', isViewed);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
        }
    }
    switch (index) {
      case 3:
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return A_propos();
          }));
        }
    }
  }
}
