class Customers {
  int id;
  String customerName;
  String gender;
  String address;
  String phoneNo;
  String age;
  String email;

  Customers(
      {this.id,
      this.customerName,
      this.gender,
      this.address,
      this.phoneNo,
      this.age,
      this.email});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'customerName': this.customerName,
      'gender': this.gender,
      'address': this.address,
      'phoneNo': this.phoneNo,
      'age': this.age,
      'email': this.email,
    };
    return map;
  }
}
