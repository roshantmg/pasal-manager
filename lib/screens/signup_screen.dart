import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pasal_manager/screens/home_screen.dart';
import 'package:pasal_manager/screens/signin_screen.dart';
import 'package:pasal_manager/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = "SIGN_UP SCREEN";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String username;
  String email;
  String password;
  String _warning;
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void userRegistration() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      //
      try {
        setState(() {
          loading = true;
        });
        var user = await _auth.createUserWithEmailAndPassword(
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
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              'Create Account',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontSize: 25,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(
              height: 35.0,
            ),
            Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      onChanged: (String value) {
                        username = value;
                      },
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      validator: NameValidator.validate,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        // suffixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 2)),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 10.0, top: 10.0),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      onChanged: (String value) {
                        email = value;
                      },
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      validator: EmailValidator.validate,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        // suffixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 2)),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 10.0, top: 10.0),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      onChanged: (String value) {
                        password = value;
                      },
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      validator: PasswordValidator.validate,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
                        // suffixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 2)),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 10.0, top: 10.0),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    loading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            hoverColor: Colors.blue,
                            highlightColor: Colors.blue,
                            elevation: 3.0,
                            onPressed: () {
                              userRegistration();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            child: Text('Sign Up'),
                            color: Colors.brown[200],
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 12.0),
                          ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignInScreen.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
