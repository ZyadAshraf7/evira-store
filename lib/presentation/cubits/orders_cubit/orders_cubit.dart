import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/models/Order.dart';
import 'package:evira_store/data/models/user.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrder(OrderModel orderModel) async {
    try {
      final DocumentReference orderDoc = _firestore
          .collection("orders")
          .doc(UserPreferences.getUserEmail())
          .collection("userOrders")
          .doc();
      OrderModel order = OrderModel(
          orderId: orderDoc.id,
          orderProducts: orderModel.orderProducts,
          userEmail: orderModel.userEmail,
          userName: orderModel.userName,
          userPhoneNumber: orderModel.userPhoneNumber,
          subTotal: orderModel.subTotal,
          shipping: orderModel.shipping,
          discount: orderModel.discount,
          total: orderModel.total,
        orderDate: Timestamp.now(),
      );
      await orderDoc.set(order.toJson());
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<OrderModel>> fetchUserOrders()async{
    try {
      List<OrderModel> userOrders = [];
      QuerySnapshot snapshot = await _firestore.collection("orders").doc(
          UserPreferences.getUserEmail()).collection("userOrders").get();
      // log(snapshot.docs.first.data().toString());
      for (var doc in snapshot.docs) {
        userOrders.add(OrderModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      if(userOrders.isNotEmpty) {
        userOrders.sort((a, b) => b.orderDate!.compareTo(a.orderDate!));
        return userOrders;
      }else{
        return userOrders;
      }
    }catch(e){
      print(e.toString());
      return [];
    }
  }
}
