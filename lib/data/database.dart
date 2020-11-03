import 'package:pasal_manager/models/borrowings.dart';
import 'package:pasal_manager/models/customers.dart';
import 'package:pasal_manager/models/expenses.dart';
import 'package:pasal_manager/models/product.dart';
import 'package:pasal_manager/models/purchase.dart';
import 'package:pasal_manager/models/sales.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Database _db;
  static int get _version => 2;
  static String productTable = 'PRODUCT';
  static String salesTable = 'SALES';
  static String purchaseTable = 'PURCHASE';
  static String expenseTable = 'EXPENSES';
  static String borrowTable = 'BORROW';
  static String customerTable = 'CUSTOMER';

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() +
          'product' +
          'sales' +
          'purchase' +
          'expenses' +
          'borrow' +
          'customer';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (e) {
      print(e.toString());
    }
  }

  static void onCreate(Database db, int version) async {
    db.execute("CREATE TABLE $productTable("
        "id INTEGER PRIMARY KEY,"
        "productName TEXT,"
        "productDescription TEXT,"
        "category TEXT,"
        "companyName TEXT,"
        "purchasePrice INTEGER,"
        "salesPrice INTEGER,"
        "quantity INTEGER,"
        "productDate TEXT"
        ")");
    db.execute("CREATE TABLE $salesTable("
        "id INTEGER PRIMARY KEY,"
        "productName TEXT,"
        "customerName TEXT,"
        "salesDate TEXT,"
        "quantity INTEGER,"
        "remarks TEXT,"
        "salesAmount INTEGER"
        ")");
    db.execute("CREATE TABLE $purchaseTable("
        "id INTEGER PRIMARY KEY,"
        "purchaseDate TEXT,"
        "productName TEXT,"
        "supplierName TEXT,"
        "quantity INTEGER,"
        "vat INTEGER,"
        "pricePerUnit INTEGER"
        ")");
    db.execute("CREATE TABLE $expenseTable("
        "id INTEGER PRIMARY KEY,"
        "expenseDate TEXT,"
        "typeExpense TEXT,"
        "amount INTEGER"
        ")");
    db.execute("CREATE TABLE $borrowTable("
        "id INTEGER PRIMARY KEY,"
        "productName TEXT,"
        "customerName TEXT,"
        "phoneNo TEXT,"
        "quantity INTEGER,"
        "perUnitPrice INTEGER,"
        "borrowDate TEXT,"
        "remark TEXT"
        ")");
    db.execute("CREATE TABLE $customerTable("
        "id INTEGER PRIMARY KEY,"
        "customerName TEXT,"
        "gender TEXT,"
        "address TEXT,"
        "phoneNo TEXT,"
        "age TEXT,"
        "email TEXT"
        ")");
  }

//product
  static Future<int> insert(Datas datas) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $productTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $productTable(id,productName,productDescription,category,companyName,purchasePrice,salesPrice,quantity,productDate)"
        "VALUES(?,?,?,?,?,?,?,?,?)",
        [
          id,
          datas.productName,
          datas.productDescription,
          datas.companyName,
          datas.category,
          datas.purchasePrice,
          datas.salesPrice,
          datas.quantity,
          datas.productDate,
        ]);
    return raw;
  }

  static Future<List<Datas>> query() async {
    List<Datas> _datasList = [];
    var res = await _db.query('$productTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _datasList.add(Datas(
            id: res[i]["id"],
            productName: res[i]["productName"],
            productDescription: res[i]["productDescription"],
            companyName: res[i]["companyName"],
            category: res[i]["category"],
            purchasePrice: res[i]["purchasePrice"],
            salesPrice: res[i]["salesPrice"],
            quantity: res[i]["quantity"],
            productDate: res[i]["productDate"]));
      }
    }
    return _datasList;
  }

  static Future<int> update(Datas datas) async {
    return await _db.update('$productTable', datas.toMap(),
        where: 'id = ?', whereArgs: [datas.id]);
  }

  static Future<int> delete(Datas datas) async {
    return await _db
        .delete('$productTable', where: 'id = ?', whereArgs: [datas.id]);
  }

//Sales
  static Future<int> insertSales(SalesData salesData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $salesTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $salesTable(id,productName,customerName,salesDate,quantity,remarks,salesAmount)"
        "VALUES(?,?,?,?,?,?,?)",
        [
          id,
          salesData.productName,
          salesData.customerName,
          salesData.salesDate,
          salesData.quantity,
          salesData.remarks,
          salesData.saleAmount,
        ]);
    return raw;
  }

  static Future<List<SalesData>> querySales() async {
    List<SalesData> _salesList = [];
    var res = await _db.query('$salesTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _salesList.add(SalesData(
          id: res[i]["id"],
          productName: res[i]["productName"],
          customerName: res[i]["customerName"],
          salesDate: res[i]["salesDate"],
          quantity: res[i]["quantity"],
          remarks: res[i]["remarks"],
          saleAmount: res[i]["salesAmount"],
        ));
      }
    }
    return _salesList;
  }

  static Future<int> updateSales(SalesData salesData) async {
    return await _db.update('$salesTable', salesData.toMap(),
        where: 'id = ?', whereArgs: [salesData.id]);
  }

  static Future<int> deleteSales(SalesData salesData) async {
    return await _db
        .delete('$salesTable', where: 'id = ?', whereArgs: [salesData.id]);
  }

//purchase
  static Future<int> insertPurchase(PurchaseData purchaseData) async {
    var table =
        await _db.rawQuery("SELECT MAX(id)+1 as id from $purchaseTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $purchaseTable(id,purchaseDate,productName,supplierName,quantity,vat,pricePerUnit)"
        "VALUES(?,?,?,?,?,?,?)",
        [
          id,
          purchaseData.purchaseDate,
          purchaseData.productName,
          purchaseData.supplierName,
          purchaseData.quantity,
          purchaseData.vat,
          purchaseData.pricePerUnit,
        ]);
    return raw;
  }

  static Future<List<PurchaseData>> queryPurchase() async {
    List<PurchaseData> _purchaseList = [];
    var res = await _db.query('$purchaseTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _purchaseList.add(PurchaseData(
          id: res[i]["id"],
          purchaseDate: res[i]["purchaseDate"],
          productName: res[i]["productName"],
          supplierName: res[i]["supplierName"],
          quantity: res[i]["quantity"],
          vat: res[i]["vat"],
          pricePerUnit: res[i]["pricePerUnit"],
        ));
      }
    }
    return _purchaseList;
  }

  static Future<int> updatePurchase(PurchaseData purchaseData) async {
    return await _db.update('$purchaseTable', purchaseData.toMap(),
        where: 'id = ?', whereArgs: [purchaseData.id]);
  }

  static Future<int> deletePurchase(PurchaseData purchaseData) async {
    return await _db.delete('$purchaseTable',
        where: 'id = ?', whereArgs: [purchaseData.id]);
  }

  //expense
  static Future<int> insertExpense(ExpensesData expensesData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $expenseTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $expenseTable(id,expenseDate,typeExpense,amount)"
        "VALUES(?,?,?,?)",
        [
          id,
          expensesData.expenseDate,
          expensesData.typeExpense,
          expensesData.amount,
        ]);
    return raw;
  }

  static Future<List<ExpensesData>> queryExpense() async {
    List<ExpensesData> _expenseList = [];
    var res = await _db.query('$expenseTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _expenseList.add(ExpensesData(
            id: res[i]["id"],
            expenseDate: res[i]["expenseDate"],
            typeExpense: res[i]["typeExpense"],
            amount: res[i]["amount"]));
      }
    }
    return _expenseList;
  }

  static Future<int> updateExpense(ExpensesData expensesData) async {
    return await _db.update('$expenseTable', expensesData.toMap(),
        where: 'id = ?', whereArgs: [expensesData.id]);
  }

  static Future<int> deleteExpense(ExpensesData expensesData) async {
    return await _db
        .delete('$expenseTable', where: 'id = ?', whereArgs: [expensesData.id]);
  }

  //borrow
  static Future<int> insertBorrow(BorrowData borrowData) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id from $borrowTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $borrowTable(id,productName,customerName,phoneNo,quantity,perUnitPrice,borrowDate,remark)"
        "VALUES(?,?,?,?,?,?,?,?)",
        [
          id,
          borrowData.productName,
          borrowData.customerName,
          borrowData.phoneNo,
          borrowData.quantity,
          borrowData.perUnitPrice,
          borrowData.borrowDate,
          borrowData.remark,
        ]);
    return raw;
  }

  static Future<List<BorrowData>> queryBorrow() async {
    List<BorrowData> _borrowList = [];
    var res = await _db.query('$borrowTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _borrowList.add(BorrowData(
          id: res[i]["id"],
          productName: res[i]["productName"],
          customerName: res[i]["customerName"],
          phoneNo: res[i]["phoneNo"],
          quantity: res[i]["quantity"],
          perUnitPrice: res[i]["perUnitPrice"],
          borrowDate: res[i]["borrowDate"],
          remark: res[i]["remark"],
        ));
      }
    }
    return _borrowList;
  }

  static Future<int> updateBorrow(BorrowData borrowData) async {
    return await _db.update('$borrowTable', borrowData.toMap(),
        where: 'id = ?', whereArgs: [borrowData.id]);
  }

  static Future<int> deleteBorrow(BorrowData borrowData) async {
    return await _db
        .delete('$borrowTable', where: 'id = ?', whereArgs: [borrowData.id]);
  }

  //customers
  static Future<int> insertCustomer(Customers customers) async {
    var table =
        await _db.rawQuery("SELECT MAX(id)+1 as id from $customerTable");
    int id = table.first['id'];
    var raw = await _db.rawInsert(
        "INSERT INTO $customerTable(id,customerName,gender,address,phoneNo,age,email)"
        "VALUES(?,?,?,?,?,?,?)",
        [
          id,
          customers.customerName,
          customers.gender,
          customers.address,
          customers.phoneNo,
          customers.age,
          customers.email,
        ]);
    return raw;
  }

  static Future<List<Customers>> queryCustomer() async {
    List<Customers> _customersList = [];
    var res = await _db.query('$customerTable');
    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        _customersList.add(Customers(
          id: res[i]["id"],
          customerName: res[i]["customerName"],
          gender: res[i]["gender"],
          address: res[i]["address"],
          phoneNo: res[i]["phoneNo"],
          age: res[i]["age"],
          email: res[i]["email"],
        ));
      }
    }
    return _customersList;
  }

  static Future<int> updateCustomer(Customers customers) async {
    return await _db.update('$customerTable', customers.toMap(),
        where: 'id = ?', whereArgs: [customers.id]);
  }

  static Future<int> deleteCustomer(Customers customers) async {
    return await _db
        .delete('$customerTable', where: 'id = ?', whereArgs: [customers.id]);
  }
}
