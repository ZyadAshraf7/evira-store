import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String? orderId;
  List<Product>? orderProducts;
  UserModel? user;
  int ?subTotal;
  int ?shipping;
  int ?discount;
  int ?total;

  OrderModel({
    required this.orderId,
    required this.orderProducts,
    required this.user,
  });

  OrderModel.fromJson(Map<String,dynamic>json){
    user = json["user"];
    orderId = json["orderId"];
    orderProducts = json["orderProducts"];
    subTotal = json["subTotal"];
    shipping = json["shipping"];
    discount = json["discount"];
    total = json["total"];
  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = <String, dynamic>{};
    data["user"] = user;
    data["orderId"] = orderId;
    data["orderProducts"] = orderProducts;
    data["subTotal"] = subTotal;
    data["shipping"] = shipping;
    data["discount"] = discount;
    data["total"] = total;
    return data;
  }
}
