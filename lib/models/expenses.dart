class ExpensesData {
  int id;
  String expenseDate;
  String typeExpense;
  int amount;

  ExpensesData({this.id, this.expenseDate, this.typeExpense, this.amount});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'expenseDate': this.expenseDate,
      'typeExpense': this.typeExpense,
      'amount': this.amount,
    };
    return map;
  }
}
