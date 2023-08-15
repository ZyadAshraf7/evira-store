import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String? orderId;
  List<dynamic>? orderProducts;
  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  double ?subTotal;
  double ?shipping;
  double ?discount;
  double ?total;
  Timestamp? orderDate;
  String? address;

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
    this.orderDate,
    required this.address
  });

  OrderModel.fromJson(Map<String,dynamic>json){
    userName = json["userName"];
    userEmail = json["userEmail"];
    userPhoneNumber = json["userPhoneNumber"];
    orderId = json["orderId"];
    orderProducts = json["orderProducts"].map((e)=>Product.fromJson(e)).toList();
    subTotal = json["subTotal"];
    shipping = json["shipping"];
    discount = json["discount"];
    total = json["total"];
    orderDate = json["orderDate"];
    address = json["address"];
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
    data["orderDate"] = orderDate;
    data["address"] = address;

    return data;
  }
}
