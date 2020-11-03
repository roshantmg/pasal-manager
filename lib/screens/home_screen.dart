import 'package:flutter/material.dart';
import 'package:pasal_manager/screens/about_screen.dart';
import 'package:pasal_manager/screens/profile_screen.dart';
import 'package:pasal_manager/screens/splash_screen.dart';

import 'package:pasal_manager/widgets/category_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HOME SCREEN';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // getEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Text(prefs.getString('USER_EMAIL'));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Pasal Manager')),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Username'),
                accountEmail: Text('e-mail'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share App'),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Rate App'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AboutScreen();
                  }));
                },
                leading: Icon(Icons.new_releases),
                title: Text('About App'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  'Welcome !',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text('Username'),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.02,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'General Report of your Pasal',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      DataTable(
                          dataRowHeight: 35.0,
                          headingRowHeight: 35.0,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text('No'),
                            ),
                            DataColumn(
                              label: Text('Summary'),
                            ),
                            DataColumn(
                              label: Text('Amount'),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(cells: <DataCell>[
                              DataCell(
                                Text('1'),
                              ),
                              DataCell(
                                Text('Total Purchase'),
                              ),
                              DataCell(
                                Text('rs 1000'),
                              ),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(
                                Text('2'),
                              ),
                              DataCell(
                                Text('Total Sales'),
                              ),
                              DataCell(
                                Text('rs 3000'),
                              ),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(
                                Text('3'),
                              ),
                              DataCell(
                                Text('Total Expenses'),
                              ),
                              DataCell(
                                Text('rs 4000'),
                              ),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(
                                Text('4'),
                              ),
                              DataCell(
                                Text('Total Profit'),
                              ),
                              DataCell(Text('rs 4000')),
                            ])
                          ]),
                    ],
                  ),
                ),
                Category(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ProfileScreen();
                            }),
                          );
                        }),
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        //request to logout in server;
                        prefs.setBool("USER_LOGIN", false);
                        prefs.setString("USER_EMAIL", null);
                        Navigator.pushReplacementNamed(
                            context, SplashScreen.id);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
