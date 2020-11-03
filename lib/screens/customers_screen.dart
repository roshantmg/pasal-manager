import 'package:flutter/material.dart';
import 'package:pasal_manager/data/curd.dart';
import 'package:pasal_manager/icons/icons.dart';
import 'package:pasal_manager/models/customers.dart';
import 'package:pasal_manager/widgets/text_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataCollection>(
      builder: (context, customer, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Customers Record'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              splashColor: Colors.blue,
              backgroundColor: Colors.purple,
              onPressed: () {
                Customers _customers = Customers();

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
                                      hintValue: 'Customer Name',
                                      onChanged: (value) {
                                        _customers.customerName = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Gender',
                                      onChanged: (value) {
                                        _customers.gender = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Address',
                                      onChanged: (value) {
                                        _customers.address = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Phone no',
                                      keyboard: TextInputType.phone,
                                      onChanged: (value) {
                                        _customers.phoneNo = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'Age',
                                      keyboard: TextInputType.number,
                                      onChanged: (value) {
                                        _customers.age = value;
                                      },
                                    ),
                                    CustomTextField(
                                      hintValue: 'E-mail',
                                      onChanged: (value) {
                                        _customers.email = value;
                                      },
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
                                        customer.insertCustomer(_customers);
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
                                    Icon(
                                      MyIcons.customer,
                                      size: 140.0,
                                      color: Colors.purple,
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    });
              },
            ),
            body: FutureBuilder<List<Customers>>(
              future: customer.getcustomersList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Customers>> snapshot) {
                if (snapshot.hasData) {
                  List<Customers> customersList = snapshot.data;
                  if (customersList.length > 0) {
                    return ListView.builder(
                      itemCount: customersList.length,
                      itemBuilder: (context, position) {
                        Customers resultCustomer = customersList[position];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            color: Colors.purple[200],
                            elevation: 10.0,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Customer Name : ${resultCustomer.customerName}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              Customers _customers =
                                                  customersList[position];
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
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
                                                                  hintValue:
                                                                      _customers
                                                                          .customerName,
                                                                  onChanged:
                                                                      (value) {
                                                                    _customers
                                                                            .customerName =
                                                                        value;
                                                                  },
                                                                ),
                                                                CustomTextField(
                                                                  hintValue:
                                                                      _customers
                                                                          .gender,
                                                                  onChanged:
                                                                      (value) {
                                                                    _customers
                                                                            .gender =
                                                                        value;
                                                                  },
                                                                ),
                                                                CustomTextField(
                                                                  hintValue:
                                                                      _customers
                                                                          .address,
                                                                  onChanged:
                                                                      (value) {
                                                                    _customers
                                                                            .address =
                                                                        value;
                                                                  },
                                                                ),
                                                                CustomTextField(
                                                                  hintValue:
                                                                      _customers
                                                                          .phoneNo,
                                                                  keyboard:
                                                                      TextInputType
                                                                          .phone,
                                                                  onChanged:
                                                                      (value) {
                                                                    _customers
                                                                            .phoneNo =
                                                                        value;
                                                                  },
                                                                ),
                                                                CustomTextField(
                                                                  hintValue:
                                                                      _customers
                                                                          .age,
                                                                  keyboard:
                                                                      TextInputType
                                                                          .number,
                                                                  onChanged:
                                                                      (value) {
                                                                    _customers
                                                                            .age =
                                                                        value;
                                                                  },
                                                                ),
                                                                CustomTextField(
                                                                  hintValue:
                                                                      _customers
                                                                          .email,
                                                                  keyboard:
                                                                      TextInputType
                                                                          .emailAddress,
                                                                  onChanged:
                                                                      (value) {
                                                                    _customers
                                                                            .email =
                                                                        value;
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      MediaQuery.of(context).viewInsets.bottom ==
                                                                              0
                                                                          ? 10
                                                                          : 300,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    customer.updateCustomer(
                                                                        _customers);
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
                                                                        EdgeInsets.all(
                                                                            20.0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      border: Border.all(
                                                                          width:
                                                                              0.8,
                                                                          color:
                                                                              Colors.black38),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Update',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
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
                                              customer.removeCustomer(
                                                  customersList[position]);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Age: ${resultCustomer.age}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                  Text(
                                    'Gender : ${resultCustomer.gender}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                  Text(
                                    'Address : ${resultCustomer.address}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.phone),
                                        onPressed: () {
                                          launch(
                                              'tel://${resultCustomer.phoneNo}');
                                        },
                                        color: Colors.green,
                                        iconSize: 20.0,
                                      ),
                                      Text(
                                        'Phone no : ${resultCustomer.phoneNo}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.email),
                                        onPressed: () {
                                          launch(
                                              'mailto:${resultCustomer.email}');
                                        },
                                        color: Colors.redAccent,
                                        iconSize: 20.0,
                                      ),
                                      Text(
                                        'E-mail : ${resultCustomer.email}',
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
                        'Add Customer Details.',
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
