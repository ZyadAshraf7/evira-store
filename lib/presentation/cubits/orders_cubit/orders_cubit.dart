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
  List<OrderModel> userOrders = [];

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
        address: orderModel.address,
      );
      await orderDoc.set(order.toJson());
      userOrders.insert(0, order);
    }catch(e){
      print(e.toString());
    }
  }

  Future<List<OrderModel>> fetchUserOrders()async{
    emit(FetchOrdersLoading());
    try {
      QuerySnapshot snapshot = await _firestore.collection("orders").doc(
          UserPreferences.getUserEmail()).collection("userOrders").get();
      // log(snapshot.docs.first.data().toString());
      if(snapshot.docs.isNotEmpty) {
        userOrders.clear();
        for (var doc in snapshot.docs) {
          userOrders.add(OrderModel.fromJson(doc.data() as Map<String, dynamic>));
        }
        userOrders.sort((a, b) => b.orderDate!.compareTo(a.orderDate!));
        emit(FetchOrdersLoaded());
        return userOrders;
      }else{
        emit(FetchOrdersEmpty());
        return userOrders;
      }
    }catch(e){
      print(e.toString());
      emit(FetchOrdersFailed());
      return [];
    }
  }
  Future<void>deleteOrder(String orderId)async{
    emit(DeleteOrderLoading());
    try {
      print(orderId);
      String documentPath = "orders/${UserPreferences.getUserEmail()}/userOrders/$orderId";
      await _firestore.doc(documentPath).delete();
      /*await _firestore.collection("users").doc(UserPreferences.getUserEmail())
          .collection("userOrders").doc(orderId)
          .delete();*/
      userOrders.removeWhere((element) => element.orderId == orderId);
      emit(DeleteOrderDone());
    }catch(e){
      emit(DeleteOrderFailed());
    }
  }
}
