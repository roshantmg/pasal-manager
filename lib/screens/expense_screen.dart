import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pasal_manager/data/curd.dart';
import 'package:pasal_manager/icons/icons.dart';
import 'package:pasal_manager/models/expenses.dart';
import 'package:pasal_manager/widgets/text_field.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, expensedata, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Expenses Record'),
            ),
            floatingActionButton: FloatingActionButton(
              splashColor: Colors.blue,
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.add),
              onPressed: () {
                ExpensesData _expensesData = ExpensesData();
                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                _expensesData.expenseDate = (formatter.format(now).toString());

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView(
                                children: [
                                  CustomTextField(
                                    hintValue: 'Type of Expense',
                                    onChanged: (value) {
                                      _expensesData.typeExpense = value;
                                    },
                                  ),
                                  CustomTextField(
                                    hintValue: 'Amount',
                                    keyboard: TextInputType.number,
                                    onChanged: (value) {
                                      _expensesData.amount = int.parse(value);
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
                                          _expensesData.expenseDate = (formatter
                                              .format(date)
                                              .toString());
                                        });
                                      }, onConfirm: (date) {
                                        final DateFormat formatter =
                                            DateFormat('yyyy-MM-dd');
                                        state(() {
                                          _expensesData.expenseDate = (formatter
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
                                          _expensesData.expenseDate,
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
                                      expensedata.insertExpense(_expensesData);
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
                                  Icon(
                                    MyIcons.expense,
                                    size: 120.0,
                                    color: Colors.redAccent,
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  },
                );
              },
            ),
            body: FutureBuilder<List<ExpensesData>>(
                future: expensedata.getexpenseList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ExpensesData>> snapshot) {
                  if (snapshot.hasData) {
                    List<ExpensesData> expenseList = snapshot.data;
                    if (expenseList.length > 0) {
                      return ListView.builder(
                        itemCount: expenseList.length,
                        itemBuilder: (context, position) {
                          ExpensesData resultExpense = expenseList[position];

                          return Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              1: FlexColumnWidth(1.8),
                              2: FlexColumnWidth(0.9),
                              3: FlexColumnWidth(.5),
                              4: FlexColumnWidth(.6),
                            },
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                  ),
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        'Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Type of Expense',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Amount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              TableRow(children: <Widget>[
                                Text(
                                  resultExpense.expenseDate,
                                ),
                                Text(
                                  resultExpense.typeExpense,
                                ),
                                Center(
                                  child: Text(
                                    'Rs ${(resultExpense.amount).toString()}',
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      ExpensesData _expensedata =
                                          expenseList[position];
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder:
                                                (BuildContext context, state) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                },
                                                child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            200,
                                                    child: ListView(
                                                      children: [
                                                        CustomTextField(
                                                          hintValue:
                                                              _expensedata
                                                                  .typeExpense,
                                                          onChanged: (value) {
                                                            _expensedata
                                                                    .typeExpense =
                                                                value;
                                                          },
                                                        ),
                                                        CustomTextField(
                                                          keyboard:
                                                              TextInputType
                                                                  .number,
                                                          hintValue:
                                                              (_expensedata
                                                                      .amount)
                                                                  .toString(),
                                                          onChanged: (value) {
                                                            _expensedata
                                                                    .amount =
                                                                int.parse(
                                                                    value);
                                                          },
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            DatePicker.showDatePicker(
                                                                context,
                                                                showTitleActions:
                                                                    true,
                                                                minTime:
                                                                    DateTime(
                                                                        1999,
                                                                        3,
                                                                        5),
                                                                maxTime:
                                                                    DateTime
                                                                        .now(),
                                                                onChanged:
                                                                    (date) {
                                                              final DateFormat
                                                                  formatter =
                                                                  DateFormat(
                                                                      'yyyy-MM-dd');

                                                              state(() {
                                                                _expensedata
                                                                        .expenseDate =
                                                                    (formatter
                                                                        .format(
                                                                            date)
                                                                        .toString());
                                                              });
                                                            }, onConfirm:
                                                                    (date) {
                                                              final DateFormat
                                                                  formatter =
                                                                  DateFormat(
                                                                      'yyyy-MM-dd');
                                                              state(() {
                                                                _expensedata
                                                                        .expenseDate =
                                                                    (formatter
                                                                        .format(
                                                                            date)
                                                                        .toString());
                                                              });
                                                            },
                                                                currentTime:
                                                                    DateTime
                                                                        .now(),
                                                                locale:
                                                                    LocaleType
                                                                        .en);
                                                          },
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.0),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                                ),
                                                                border: Border.all(
                                                                    width: 0.8,
                                                                    color: Colors
                                                                        .black38),
                                                              ),
                                                              child: Text(
                                                                _expensedata
                                                                    .expenseDate,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom ==
                                                                  0
                                                              ? 10
                                                              : 300,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            expensedata
                                                                .updateExpense(
                                                                    _expensedata);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        20.0),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              border: Border.all(
                                                                  width: 0.8,
                                                                  color: Colors
                                                                      .black38),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Update',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20.0,
                                                        ),
                                                        Icon(
                                                          MyIcons.expense,
                                                          size: 120.0,
                                                          color:
                                                              Colors.redAccent,
                                                        )
                                                      ],
                                                    )),
                                              );
                                            },
                                          );
                                        },
                                      );
                                      //
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      expensedata
                                          .removeExpense(expenseList[position]);
                                    }),
                              ])
                            ],
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text(
                            'Add your Expenses.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container(
                      child: Text('Add your expenses.'),
                    );
                  }
                }));
      },
    );
  }
}
