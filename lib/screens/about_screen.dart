import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.store,
                  size: 50.0,
                  color: Colors.blue,
                ),
                Text(
                  'PASAL MANAGER',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Pasal Manager is a management app with the vision of giving easier and flexible way of managing a store. It aims to be the brain of any store so your support will be warmly welcomed.',
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Supported By:',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text('Suresh Sir'),
          ],
        ),
      ),
    );
  }
}
