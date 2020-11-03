import 'package:flutter/material.dart';
import 'package:pasal_manager/screens/home_screen.dart';
import 'package:pasal_manager/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static final String id = "SPLASH SCREEN";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  void checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      bool userLogin = prefs.getBool("USER_LOGIN");
      if (userLogin) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, SignInScreen.id);
      }
    } catch (e) {
      Navigator.pushReplacementNamed(context, SignInScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading..........'),
      ),
    );
  }
}
