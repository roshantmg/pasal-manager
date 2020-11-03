import 'dart:io';

class Datas {
  int id;
  String productName;
  String productDescription;
  String category;
  String companyName;
  int purchasePrice;
  int salesPrice;
  int quantity;
  File image;
  String productDate;

  Datas({
    this.id,
    this.productName,
    this.productDescription,
    this.category,
    this.image,
    this.companyName,
    this.purchasePrice,
    this.quantity,
    this.salesPrice,
    this.productDate,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'productName': this.productName,
      'productDescription': this.productDescription,
      'category': this.category,
      // 'image': this.image,
      'companyName': this.companyName,
      'purchasePrice': this.purchasePrice,
      'quantity': this.quantity,
      'salesPrice': this.salesPrice,
      'productDate': this.productDate,
    };
    return map;
  }
}
