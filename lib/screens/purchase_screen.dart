import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pasal_manager/data/curd.dart';
import 'package:pasal_manager/icons/icons.dart';
import 'package:pasal_manager/models/purchase.dart';
import 'package:pasal_manager/widgets/text_field.dart';
import 'package:provider/provider.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, purchaseData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Purchase Record'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.green,
              onPressed: () {
                PurchaseData _purchasedata = PurchaseData();

                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                _purchasedata.purchaseDate = (formatter.format(now).toString());
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: ListView(
                                  children: [
                                    CustomTextField(
                                      hintValue: 'Product Name',
                                      onChanged: (value) {
                                        _purchasedata.productName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Supplier Name',
                                      onChanged: (value) {
                                        _purchasedata.supplierName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Quantity',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _purchasedata.quantity =
                                            int.parse(value);
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'VAT',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _purchasedata.vat = int.parse(value);
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Price Per Unit',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _purchasedata.pricePerUnit =
                                            int.parse(value);
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1999, 3, 5),
                                            maxTime: DateTime.now(),
                                            onChanged: (date) {
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');

                                          state(() {
                                            _purchasedata.purchaseDate =
                                                (formatter
                                                    .format(date)
                                                    .toString());
                                          });
                                        }, onConfirm: (date) {
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');
                                          state(() {
                                            _purchasedata.purchaseDate =
                                                (formatter
                                                    .format(date)
                                                    .toString());
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          padding: EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                            border: Border.all(
                                                width: 0.8,
                                                color: Colors.black38),
                                          ),
                                          child: Text(
                                            _purchasedata.purchaseDate,
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom ==
                                              0
                                          ? 10
                                          : 300,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        purchaseData
                                            .insertPurchase(_purchasedata);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              width: 0.8,
                                              color: Colors.black38),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Icon(MyIcons.purchase,
                                        size: 100.0, color: Colors.redAccent)
                                  ],
                                )),
                          );
                        },
                      );
                    });
              },
            ),
            body: FutureBuilder<List<PurchaseData>>(
              future: purchaseData.getPurchaseList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<PurchaseData>> snapshot) {
                if (snapshot.hasData) {
                  List<PurchaseData> purchaseList = snapshot.data;
                  if (purchaseList.length > 0) {
                    return ListView.builder(
                      itemCount: purchaseList.length,
                      itemBuilder: (context, position) {
                        PurchaseData resultPurchase = purchaseList[position];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.redAccent[100],
                            elevation: 10.0,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Product : ${resultPurchase.productName}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(
                                            'Price Per Unit : ${resultPurchase.pricePerUnit}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                      ]),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Supplier Name : ${resultPurchase.supplierName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text('VAT : ${resultPurchase.vat}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Quantity : ${resultPurchase.quantity.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Total : ${resultPurchase.pricePerUnit * resultPurchase.quantity + resultPurchase.vat}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                            'Date : ${resultPurchase.purchaseDate}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                        Row(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                size: 20.0,
                                              ),
                                              onPressed: () {
                                                PurchaseData _purchasedata =
                                                    purchaseList[position];

                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                        builder:
                                                            (context, state) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      new FocusNode());
                                                            },
                                                            child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height -
                                                                    200,
                                                                child: ListView(
                                                                  children: [
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          _purchasedata
                                                                              .productName,
                                                                      onChanged:
                                                                          (value) {
                                                                        _purchasedata.productName =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          _purchasedata
                                                                              .supplierName,
                                                                      onChanged:
                                                                          (value) {
                                                                        _purchasedata.supplierName =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          (_purchasedata.quantity)
                                                                              .toString(),
                                                                      keyboard:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        _purchasedata.quantity =
                                                                            int.parse(value);
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          (_purchasedata.vat)
                                                                              .toString(),
                                                                      keyboard:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        _purchasedata.vat =
                                                                            int.parse(value);
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          (_purchasedata.pricePerUnit)
                                                                              .toString(),
                                                                      keyboard:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        _purchasedata.pricePerUnit =
                                                                            int.parse(value);
                                                                      },
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        DatePicker.showDatePicker(
                                                                            context,
                                                                            showTitleActions:
                                                                                true,
                                                                            minTime: DateTime(
                                                                                1999,
                                                                                3,
                                                                                5),
                                                                            maxTime:
                                                                                DateTime.now(),
                                                                            onChanged:
                                                                                (date) {
                                                                          final DateFormat
                                                                              formatter =
                                                                              DateFormat('yyyy-MM-dd');

                                                                          state(
                                                                              () {
                                                                            _purchasedata.purchaseDate =
                                                                                (formatter.format(date).toString());
                                                                          });
                                                                        }, onConfirm:
                                                                                (date) {
                                                                          final DateFormat
                                                                              formatter =
                                                                              DateFormat('yyyy-MM-dd');
                                                                          state(
                                                                              () {
                                                                            _purchasedata.purchaseDate =
                                                                                (formatter.format(date).toString());
                                                                          });
                                                                        },
                                                                            currentTime:
                                                                                DateTime.now(),
                                                                            locale: LocaleType.en);
                                                                      },
                                                                      child: Container(
                                                                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                                                                          padding: EdgeInsets.all(20.0),
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.all(
                                                                              Radius.circular(20.0),
                                                                            ),
                                                                            border:
                                                                                Border.all(width: 0.8, color: Colors.black38),
                                                                          ),
                                                                          child: Text(
                                                                            _purchasedata.purchaseDate,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          )),
                                                                    ),
                                                                    SizedBox(
                                                                      height: MediaQuery.of(context).viewInsets.bottom ==
                                                                              0
                                                                          ? 10
                                                                          : 300,
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        purchaseData
                                                                            .updatePurchase(_purchasedata);
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10.0,
                                                                            horizontal:
                                                                                20.0),
                                                                        padding:
                                                                            EdgeInsets.all(20.0),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.blue,
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                          border: Border.all(
                                                                              width: 0.8,
                                                                              color: Colors.black38),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Update',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20.0,
                                                                    ),
                                                                    Icon(
                                                                        MyIcons
                                                                            .purchase,
                                                                        size:
                                                                            100.0,
                                                                        color: Colors
                                                                            .redAccent)
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                      );
                                                    });
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  size: 20.0),
                                              onPressed: () {
                                                purchaseData.removePurchase(
                                                    purchaseList[position]);
                                              },
                                            ),
                                          ],
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        );
                        //
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text(
                          'Add your Purchases.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                } else {
                  return Container(
                    child: Text('ADD DATA'),
                  );
                }
              },
            ));
      },
    );
  }
}
