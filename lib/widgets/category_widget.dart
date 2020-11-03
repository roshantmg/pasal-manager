import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pasal_manager/icons/icons.dart';
import 'package:pasal_manager/screens/Product_screen.dart';
import 'package:pasal_manager/screens/borrow_screen.dart';
import 'package:pasal_manager/screens/calculator_screen.dart';
import 'package:pasal_manager/screens/customers_screen.dart';
import 'package:pasal_manager/screens/expense_screen.dart';
import 'package:pasal_manager/screens/purchase_screen.dart';
import 'package:pasal_manager/screens/sales_screen.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Widget categorylist(
    String categoryname,
    final Color colors,
    final IconData icons,
    final Widget widget,
  ) {
    return Card(
      // margin: EdgeInsets.all(14.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return widget;
            }),
          );
        },
        splashColor: Colors.blue,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icons,
                color: colors,
                size: 50.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                categoryname,
                style: new TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold, color: colors),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.13,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          padding: EdgeInsets.all(5.0),
          crossAxisCount: 3,
          children: [
            categorylist(
              'ITEM / PRODUCT',
              Colors.black,
              MyIcons.item,
              ProductScreen(),
            ),
            categorylist(
              'SALES',
              Colors.black,
              MyIcons.sale,
              SalesScreen(),
            ),
            categorylist(
              'PURCHASE',
              Colors.black,
              MyIcons.purchase,
              PurchaseScreen(),
            ),
            categorylist(
                'EXPENSES', Colors.black, MyIcons.expense, ExpenseScreen()),
            categorylist('PROFIT & LOSS', Colors.black, MyIcons.profitloss,
                SalesScreen()),
            categorylist(
              'OVERALL REPORT',
              Colors.black,
              MyIcons.report,
              SalesScreen(),
            ),
            categorylist(
                'BORROWINGS', Colors.black, MyIcons.money, BorrowScreen()),
            categorylist(
                'CUSTOMERS', Colors.black, MyIcons.customer, CustomerScreen()),
            categorylist(
                'CALCULATOR', Colors.black, Icons.calculate, Calculator()),

            /*
            NOTE THE BELOW CODE IS LONG CODE AND THE ABOVE IS SHORTER. THE BELOW CODE WORKS THE SAME AS 
            ABOVE.
            */
            //PRODUCT
            // Card(
            //   // margin: EdgeInsets.all(14.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return ProductScreen();
            //         }),
            //       );
            //     },
            //     splashColor: Colors.blue,
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Icon(
            //             MyIcons.item,
            //             color: Colors.black,
            //             size: 50.0,
            //           ),
            //           SizedBox(
            //             height: 15,
            //           ),
            //           Text(
            //             'ITEM / PRODUCT',
            //             style: new TextStyle(
            //                 fontSize: 12.0, fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // // SALES
            // Card(
            //   // margin: EdgeInsets.all(14.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return;
            //         }),
            //       );
            //     },
            //     splashColor: Colors.blue,
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Icon(
            //             MyIcons.sale,
            //             color: Colors.black,
            //             size: 50.0,
            //           ),
            //           SizedBox(
            //             height: 15.0,
            //           ),
            //           Text(
            //             'SALES',
            //             style: new TextStyle(
            //                 fontSize: 12.0,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // //Maths
            // Card(
            //   // margin: EdgeInsets.all(14.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return;
            //         }),
            //       );
            //     },
            //     splashColor: Colors.greenAccent,
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Icon(
            //             MyIcons.purchase,
            //             color: Colors.black,
            //             size: 50.0,
            //           ),
            //           SizedBox(
            //             height: 15.0,
            //           ),
            //           Text(
            //             'PURCHASE',
            //             style: new TextStyle(
            //                 fontSize: 12.0,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // //Science
            // Card(
            //   // margin: EdgeInsets.all(14.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return;
            //         }),
            //       );
            //     },
            //     splashColor: Colors.yellowAccent,
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Icon(
            //             MyIcons.expense,
            //             color: Colors.black,
            //             size: 50.0,
            //           ),
            //           SizedBox(
            //             height: 15.0,
            //           ),
            //           Text(
            //             'EXPENSES',
            //             style: new TextStyle(
            //                 fontSize: 12.0,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // //Sports
            // Card(
            //   // margin: EdgeInsets.all(14.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return;
            //         }),
            //       );
            //     },
            //     splashColor: Colors.redAccent,
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Icon(
            //             MyIcons.profitloss,
            //             color: Colors.black,
            //             size: 50.0,
            //           ),
            //           SizedBox(
            //             height: 15.0,
            //           ),
            //           Text(
            //             'PROFIT & LOSS',
            //             style: new TextStyle(
            //                 fontSize: 12.0,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // //People and Places
            // Card(
            //   // margin: EdgeInsets.all(14.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return;
            //         }),
            //       );
            //     },
            //     splashColor: Colors.pinkAccent,
            //     child: Center(
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: <Widget>[
            //           Icon(
            //             MyIcons.report,
            //             color: Colors.black,
            //             size: 50.0,
            //           ),
            //           SizedBox(
            //             height: 15.0,
            //           ),
            //           Text(
            //             'OVERALL REPORT',
            //             style: new TextStyle(
            //               fontSize: 12.0,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
