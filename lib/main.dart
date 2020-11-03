import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pasal_manager/data/curd.dart';
import 'package:pasal_manager/screens/home_screen.dart';
import 'package:pasal_manager/screens/signin_screen.dart';
import 'package:pasal_manager/screens/signup_screen.dart';
import 'package:pasal_manager/screens/splash_screen.dart';

import 'package:provider/provider.dart';

import 'data/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataCollection>(
      create: (context) => DataCollection(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        },
      ),
    );
  }
}
