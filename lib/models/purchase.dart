class PurchaseData {
  int id;
  String purchaseDate;
  String productName;
  String supplierName;
  int quantity;
  int vat;
  int pricePerUnit;

  PurchaseData(
      {this.id,
      this.purchaseDate,
      this.productName,
      this.supplierName,
      this.quantity,
      this.vat,
      this.pricePerUnit});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'purchaseDate': this.purchaseDate,
      'productName': this.productName,
      'supplierName': this.supplierName,
      'quantity': this.quantity,
      'vat': this.vat,
      'pricePerUnit': this.pricePerUnit
    };
    return map;
  }
}
