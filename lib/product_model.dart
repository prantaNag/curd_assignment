class ProductModel {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['Img'];
    productCode = json['ProductCode'];
    productName = json['ProductName'];
    quantity = json['Qty'];
    totalPrice = json['TotalPrice'];
    unitPrice = json['UnitPrice'];
  }
}
