import 'package:clopestop/UserPrefs.dart';
import 'package:clopestop/provider/google_sign_in.dart';
import 'package:clopestop/screens/home.dart';
import 'package:clopestop/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('ShowMainScreen');
  await UserPrefs.init();
  runApp(const StopClope());
}

class StopClope extends StatelessWidget {
  const StopClope({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          routes: {
            'HomeP': (context) => const HomePage(),
          },
          debugShowCheckedModeBanner: false,
          home: isViewed != 0 ? const HomePage() : const MainScreen(),
        ),
      );
}
