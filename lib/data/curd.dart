import 'package:flutter/foundation.dart';
import 'package:pasal_manager/models/borrowings.dart';
import 'package:pasal_manager/models/customers.dart';
import 'package:pasal_manager/models/expenses.dart';
import 'package:pasal_manager/models/product.dart';
import 'package:pasal_manager/models/purchase.dart';
import 'package:pasal_manager/models/sales.dart';

import 'database.dart';

class DataCollection extends ChangeNotifier {
  List<Datas> _datasList = [];
  Future<List<Datas>> getdatasList() async {
    var result = await DB.query();
    if (result != null) {
      _datasList = result;
    }
    notifyListeners();
    return _datasList;
  }

  void insertData(Datas datas) async {
    await DB.insert(datas);
    await getdatasList();

    // _datasList.add(datas);
    // notifyListeners();
  }

  void removeData(Datas datas) async {
    await DB.delete(datas);
    await getdatasList();
    // _datasList.removeAt(position);
    // notifyListeners();
  }

  void updateData(Datas datas) async {
    await DB.update(datas);
    await getdatasList();
    // _datasList[position] = datas;
    // notifyListeners();
  }

//Sales
  List<SalesData> _salesList = [];
  Future<List<SalesData>> getsalesList() async {
    var result = await DB.querySales();
    if (result != null) {
      _salesList = result;
    }
    notifyListeners();
    return _salesList;
  }

  void insertSale(SalesData salesData) async {
    await DB.insertSales(salesData);
    await getsalesList();
  }

  void removeSale(SalesData salesData) async {
    await DB.deleteSales(salesData);
    await getsalesList();
  }

  void updateSale(SalesData salesdata) async {
    await DB.updateSales(salesdata);
    await getsalesList();
  }

//expenses
  List<ExpensesData> _expenseList = [];
  Future<List<ExpensesData>> getexpenseList() async {
    var result = await DB.queryExpense();
    if (result != null) {
      _expenseList = result;
    }
    notifyListeners();
    return _expenseList;
  }

  void insertExpense(ExpensesData expensesData) async {
    await DB.insertExpense(expensesData);
    await getexpenseList();
  }

  void removeExpense(ExpensesData expensesData) async {
    await DB.deleteExpense(expensesData);
    await getexpenseList();
  }

  void updateExpense(ExpensesData expensesData) async {
    await DB.updateExpense(expensesData);
    await getexpenseList();
  }

  //purchase
  List<PurchaseData> _purchaseList = [];
  Future<List<PurchaseData>> getPurchaseList() async {
    var result = await DB.queryPurchase();
    if (result != null) {
      _purchaseList = result;
    }
    notifyListeners();
    return _purchaseList;
  }

  void insertPurchase(PurchaseData purchaseData) async {
    await DB.insertPurchase(purchaseData);
    await getPurchaseList();
  }

  void removePurchase(PurchaseData purchaseData) async {
    await DB.deletePurchase(purchaseData);
    await getPurchaseList();
  }

  void updatePurchase(PurchaseData purchasedata) async {
    await DB.updatePurchase(purchasedata);
    await getPurchaseList();
  }

//borrow
  List<BorrowData> _borrowList = [];
  Future<List<BorrowData>> getborrowList() async {
    var result = await DB.queryBorrow();
    if (result != null) {
      _borrowList = result;
    }
    notifyListeners();
    return _borrowList;
  }

  void insertBorrow(BorrowData borrowData) async {
    await DB.insertBorrow(borrowData);
    await getborrowList();
  }

  void removeborrow(BorrowData borrowData) async {
    await DB.deleteBorrow(borrowData);
    await getborrowList();
  }

  void updateBorrow(BorrowData borrowData) async {
    await DB.updateBorrow(borrowData);
    await getborrowList();
  }

//customers
  List<Customers> _customersList = [];
  Future<List<Customers>> getcustomersList() async {
    var result = await DB.queryCustomer();
    if (result != null) {
      _customersList = result;
    }
    notifyListeners();
    return _customersList;
  }

  void insertCustomer(Customers customers) async {
    await DB.insertCustomer(customers);
    await getcustomersList();

    // _datasList.add(datas);
    // notifyListeners();
  }

  void removeCustomer(Customers customers) async {
    await DB.deleteCustomer(customers);
    await getcustomersList();
    // _datasList.removeAt(position);
    // notifyListeners();
  }

  void updateCustomer(Customers customers) async {
    await DB.updateCustomer(customers);
    await getcustomersList();
    // _datasList[position] = datas;
    // notifyListeners();
  }
}
