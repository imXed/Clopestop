import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/consts.dart';
import 'package:clopestop/provider/google_sign_in.dart';
import 'package:clopestop/screens/home.dart';
import 'package:clopestop/screens/onboarding.dart';
import 'package:clopestop/screens/trophys.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    String? name = UserPrefs.getUsername();
    String? date = UserPrefs.getDate();
  }

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
                  Text('Hello'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(UserPrefs.getUsername()!),
                ],
              ),
            ),
            MenuItem(
                text: ' changer theme',
                icon: Icons.color_lens,
                onClicked: () => selectedItem(context, 0)),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.white,
            ),
            MenuItem(
                text: ' renitilialiser',
                icon: Icons.event_repeat,
                onClicked: () => selectedItem(context, 1)),
            MenuItem(
                text: ' Log out',
                icon: Icons.login_outlined,
                onClicked: () => selectedItem(context, 2)),
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
    final color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Trophys()));
    }
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
  }
}
