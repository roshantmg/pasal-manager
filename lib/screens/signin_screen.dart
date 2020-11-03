import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pasal_manager/icons/icons.dart';
import 'package:pasal_manager/screens/home_screen.dart';
import 'package:pasal_manager/screens/signup_screen.dart';
import 'package:pasal_manager/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  static String id = 'SIGNIN SCREEN';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String username;
  String email;
  String password;
  String _warning;
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void userLogin() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      try {
        setState(() {
          loading = true;
        });
        var user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          loading = false;
        });
        if (user != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          try {
            prefs.setBool("USER_LOGIN", true);
            prefs.setString("USER_EMAIL", email);
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          } catch (e) {
            print(e.message);
          }
        } else {
          print(_warning);
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        print(e.message);
      }
    } else {
      print(_warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MyIcons.purchase,
                    size: 80.0,
                    color: Colors.orange,
                  ),
                  Icon(
                    MyIcons.purchase,
                    size: 40,
                    color: Colors.orange,
                  ),
                  Icon(
                    MyIcons.purchase,
                    size: 25,
                    color: Colors.orange,
                  ),
                ],
              ),
              Text(
                'PASAL MANAGER',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.orange,
                    fontFamily: 'Times New Roman'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'S',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        fontFamily: 'Times New Roman'),
                  ),
                  Text(
                    'ign In',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 40.0,
                        fontFamily: 'Arial'),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                        validator: EmailValidator.validate,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          // suffixIcon: Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0)),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 10.0, top: 10.0),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                        validator: PasswordValidator.validate,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.vpn_key_rounded),

                          // suffixIcon: Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0)),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 10.0, top: 10.0),
                        ),
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      loading
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              hoverColor: Colors.blue,
                              highlightColor: Colors.blue,
                              elevation: 3.0,
                              onPressed: () {
                                userLogin();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0)),
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.deepOrange[300],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 12.0),
                            ),
                      SizedBox(
                        height: 25.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Forgot your password ?',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Or sign in with :',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.g_translate_rounded,
                        size: 30.0,
                        color: Colors.orange,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.face,
                        size: 30.0,
                        color: Colors.blue,
                      ),
                      onPressed: () {})
                ],
              ),
              SizedBox(height: 40.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create your new account ?',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.orange),
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.redAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
