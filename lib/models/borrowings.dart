class BorrowData {
  int id;
  String productName;
  String customerName;
  String phoneNo;
  int quantity;
  int perUnitPrice;
  String borrowDate;
  String remark;

  BorrowData(
      {this.id,
      this.productName,
      this.customerName,
      this.phoneNo,
      this.quantity,
      this.perUnitPrice,
      this.borrowDate,
      this.remark});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'productName': this.productName,
      'customerName': this.customerName,
      'phoneNo': this.phoneNo,
      'quantity': this.quantity,
      'perUnitPrice': this.perUnitPrice,
      'borrowDate': this.borrowDate,
      'remark': this.remark,
    };
    return map;
  }
}
