import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String? orderId;
  List<Product>? orderProducts;
  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  double ?subTotal;
  double ?shipping;
  double ?discount;
  double ?total;

  OrderModel({
    this.orderId,
    required this.orderProducts,
    required this.userName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.subTotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  OrderModel.fromJson(Map<String,dynamic>json){
    userName = json["userName"];
    userEmail = json["userEmail"];
    userPhoneNumber = json["userPhoneNumber"];
    orderId = json["orderId"];
    orderProducts = json["orderProducts"];
    subTotal = json["subTotal"];
    shipping = json["shipping"];
    discount = json["discount"];
    total = json["total"];
  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = <String, dynamic>{};
    data["userName"] = userName;
    data["userEmail"] = userEmail;
    data["userPhoneNumber"] = userPhoneNumber;
    data["orderId"] = orderId;
    data["orderProducts"] = orderProducts?.map((e) => e.toJson());
    data["subTotal"] = subTotal;
    data["shipping"] = shipping;
    data["discount"] = discount;
    data["total"] = total;
    return data;
  }
}
