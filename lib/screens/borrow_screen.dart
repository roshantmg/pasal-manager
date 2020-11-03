import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pasal_manager/data/curd.dart';
import 'package:pasal_manager/icons/icons.dart';
import 'package:pasal_manager/models/borrowings.dart';
import 'package:pasal_manager/widgets/text_field.dart';
import 'package:provider/provider.dart';

class BorrowScreen extends StatefulWidget {
  @override
  _BorrowScreenState createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, borrowData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Borrowings Record'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.blue,
              backgroundColor: Colors.orangeAccent,
              onPressed: () {
                BorrowData _borrowData = BorrowData();
                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                _borrowData.borrowDate = (formatter.format(now).toString());
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
                              height: MediaQuery.of(context).size.height - 150,
                              child: ListView(
                                children: [
                                  CustomTextField(
                                    hintValue: 'Product Name',
                                    onChanged: (value) {
                                      _borrowData.productName = value;
                                    },
                                  ),
                                  CustomTextField(
                                    hintValue: 'Customer Name',
                                    onChanged: (value) {
                                      _borrowData.customerName = value;
                                    },
                                  ),
                                  CustomTextField(
                                    hintValue: 'Quantity',
                                    keyboard: TextInputType.number,
                                    onChanged: (value) {
                                      _borrowData.quantity = int.parse(value);
                                    },
                                  ),
                                  CustomTextField(
                                    hintValue: 'Price Per Unit',
                                    keyboard: TextInputType.number,
                                    onChanged: (value) {
                                      _borrowData.perUnitPrice =
                                          int.parse(value);
                                    },
                                  ),
                                  CustomTextField(
                                    hintValue: 'Phone no',
                                    keyboard: TextInputType.number,
                                    onChanged: (value) {
                                      _borrowData.phoneNo = value;
                                    },
                                  ),
                                  CustomTextField(
                                    hintValue: 'Remark',
                                    onChanged: (value) {
                                      _borrowData.remark = value;
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
                                          _borrowData.borrowDate = (formatter
                                              .format(date)
                                              .toString());
                                        });
                                      }, onConfirm: (date) {
                                        final DateFormat formatter =
                                            DateFormat('yyyy-MM-dd');
                                        state(() {
                                          _borrowData.borrowDate = (formatter
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
                                          _borrowData.borrowDate,
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
                                      borrowData.insertBorrow(_borrowData);
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
                                            width: 0.8, color: Colors.black38),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Icon(MyIcons.money,
                                      size: 120.0, color: Colors.orangeAccent)
                                ],
                              )),
                        );
                      },
                    );
                  },
                );
              },
            ),
            body: FutureBuilder<List<BorrowData>>(
              future: borrowData.getborrowList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BorrowData>> snapshot) {
                if (snapshot.hasData) {
                  List<BorrowData> borrowList = snapshot.data;
                  if (borrowList.length > 0) {
                    return ListView.builder(
                        itemCount: borrowList.length,
                        itemBuilder: (context, position) {
                          BorrowData resultBorrow = borrowList[position];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Product : ${resultBorrow.productName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            'Date : ${resultBorrow.borrowDate}'),
                                      ],
                                    ),
                                    Text(
                                        'Customer Name : ${resultBorrow.customerName}'),
                                    Text('Quantity : ${resultBorrow.quantity}'),
                                    Text(
                                        'Per Unit Price : ${resultBorrow.perUnitPrice}'),
                                    Text(
                                      'Total Amount : ${resultBorrow.quantity * resultBorrow.perUnitPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Phone No : ${resultBorrow.phoneNo}'),
                                    Text('Remark : ${resultBorrow.remark}'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.phone,
                                              size: 20.0,
                                            ),
                                            onPressed: () {}),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.edit,
                                                    size: 20.0),
                                                onPressed: () {
                                                  BorrowData _borrowdata =
                                                      borrowList[position];
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
                                                                    150,
                                                                child: ListView(
                                                                  children: [
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          _borrowdata
                                                                              .productName,
                                                                      onChanged:
                                                                          (value) {
                                                                        _borrowdata.productName =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          _borrowdata
                                                                              .customerName,
                                                                      onChanged:
                                                                          (value) {
                                                                        _borrowdata.customerName =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          (_borrowdata.quantity)
                                                                              .toString(),
                                                                      keyboard:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        _borrowdata.quantity =
                                                                            int.parse(value);
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          (_borrowdata.perUnitPrice)
                                                                              .toString(),
                                                                      keyboard:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        _borrowdata.perUnitPrice =
                                                                            int.parse(value);
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          _borrowdata
                                                                              .phoneNo,
                                                                      keyboard:
                                                                          TextInputType
                                                                              .number,
                                                                      onChanged:
                                                                          (value) {
                                                                        _borrowdata.phoneNo =
                                                                            value;
                                                                      },
                                                                    ),
                                                                    CustomTextField(
                                                                      hintValue:
                                                                          _borrowdata
                                                                              .remark,
                                                                      onChanged:
                                                                          (value) {
                                                                        _borrowdata.remark =
                                                                            value;
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
                                                                            _borrowdata.borrowDate =
                                                                                (formatter.format(date).toString());
                                                                          });
                                                                        }, onConfirm:
                                                                                (date) {
                                                                          final DateFormat
                                                                              formatter =
                                                                              DateFormat('yyyy-MM-dd');
                                                                          state(
                                                                              () {
                                                                            _borrowdata.borrowDate =
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
                                                                            _borrowdata.borrowDate,
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
                                                                        borrowData
                                                                            .updateBorrow(_borrowdata);
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
                                                                            .money,
                                                                        size:
                                                                            120.0,
                                                                        color: Colors
                                                                            .orangeAccent)
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                }),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 20.0,
                                                ),
                                                onPressed: () {
                                                  borrowData.removeborrow(
                                                      borrowList[position]);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container(
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'Add the people who have to pay.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                } else {
                  return Container(
                    child: Center(
                      child: Text('Add the people who have to pay.'),
                    ),
                  );
                }
              },
            ));
      },
    );
  }
}
