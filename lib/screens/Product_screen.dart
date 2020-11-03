import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasal_manager/data/curd.dart';
import 'package:pasal_manager/models/product.dart';
import 'package:pasal_manager/widgets/image_widget.dart';
import 'package:pasal_manager/widgets/text_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, data, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Product / Item Record'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.green,
              onPressed: () {
                Datas _datas = Datas();

                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('yyyy-MM-dd');
                _datas.productDate = (formatter.format(now).toString());
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
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView(
                                  children: [
                                    CustomTextField(
                                      hintValue: 'Product Name',
                                      onChanged: (value) {
                                        _datas.productName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Product Description',
                                      onChanged: (value) {
                                        _datas.productDescription = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Category',
                                      onChanged: (value) {
                                        _datas.category = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Company Name',
                                      onChanged: (value) {
                                        _datas.companyName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Purchase Price',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _datas.purchasePrice = int.parse(value);
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Sales Price',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _datas.salesPrice = int.parse(value);
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Stock',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _datas.quantity = int.parse(value);
                                      },
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6.0,
                                      child: Center(child: ImageWidget()),
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
                                            _datas.productDate = (formatter
                                                .format(date)
                                                .toString());
                                          });
                                        }, onConfirm: (date) {
                                          final DateFormat formatter =
                                              DateFormat('yyyy-MM-dd');
                                          state(() {
                                            _datas.productDate = (formatter
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
                                            _datas.productDate,
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
                                        data.insertData(_datas);
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
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    });
              },
            ),
            body: FutureBuilder<List<Datas>>(
              future: data.getdatasList(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datas>> snapshot) {
                if (snapshot.hasData) {
                  List<Datas> datasList = snapshot.data;
                  if (datasList.length > 0) {
                    return ListView.builder(
                      itemCount: datasList.length,
                      itemBuilder: (context, position) {
                        Datas resultProduct = datasList[position];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            elevation: 10.0,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Datas _datas = datasList[position];
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    state) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
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
                                                              hintValue: _datas
                                                                  .productName,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.productName =
                                                                    value;
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue: _datas
                                                                  .productDescription,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.productDescription =
                                                                    value;
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue: _datas
                                                                  .category,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.category =
                                                                    value;
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue: _datas
                                                                  .companyName,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.companyName =
                                                                    value;
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue: (_datas
                                                                      .purchasePrice)
                                                                  .toString(),
                                                              keyboard:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.purchasePrice =
                                                                    int.parse(
                                                                        value);
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue: (_datas
                                                                      .salesPrice)
                                                                  .toString(),
                                                              keyboard:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.salesPrice =
                                                                    int.parse(
                                                                        value);
                                                              },
                                                            ),
                                                            CustomTextField(
                                                              hintValue: (_datas
                                                                      .quantity)
                                                                  .toString(),
                                                              keyboard:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {
                                                                _datas.quantity =
                                                                    int.parse(
                                                                        value);
                                                              },
                                                            ),
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  6.0,
                                                              child: Center(
                                                                  child:
                                                                      ImageWidget()),
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
                                                                    _datas.productDate = (formatter
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
                                                                    _datas.productDate = (formatter
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
                                                                      Radius.circular(
                                                                          20.0),
                                                                    ),
                                                                    border: Border.all(
                                                                        width:
                                                                            0.8,
                                                                        color: Colors
                                                                            .black38),
                                                                  ),
                                                                  child: Text(
                                                                    _datas
                                                                        .productDate,
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
                                                                data.updateData(
                                                                    _datas);
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
                                                                    EdgeInsets
                                                                        .all(
                                                                            20.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  border: Border.all(
                                                                      width:
                                                                          0.8,
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
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          data.removeData(datasList[position]);
                                        },
                                      ),
                                    ],
                                  ),
                                  // Image.file(
                                  //   resultProduct.image,

                                  // ),
                                  Text(
                                    'Product Name : ${resultProduct.productName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    'Product Description : ${resultProduct.productDescription}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Company Name : ${resultProduct.companyName}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                      Text(
                                        'Category : ${resultProduct.category}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Purchase Price : ${resultProduct.purchasePrice.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                      Text(
                                        'Sales Price : ${resultProduct.salesPrice.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Stock : ${resultProduct.quantity.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                      Text(
                                        'Date : ${resultProduct.productDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: Center(
                          child: Text(
                        'Add your product or item.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    );
                  }
                } else {
                  return Container(child: Center(child: Text('ADD DATA')));
                }
              },
            ));
      },
    );
  }
}
