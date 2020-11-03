class SalesData {
  int id;
  String productName;
  String customerName;
  String salesDate;
  int quantity;
  String remarks;
  int saleAmount;

  SalesData({
    this.id,
    this.productName,
    this.customerName,
    this.salesDate,
    this.quantity,
    this.remarks,
    this.saleAmount,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'productName': this.productName,
      'customerName': this.customerName,
      'salesDate': this.salesDate,
      'quantity': this.quantity,
      'remarks': this.remarks,
      'salesAmount': this.saleAmount
    };
    return map;
  }
}
