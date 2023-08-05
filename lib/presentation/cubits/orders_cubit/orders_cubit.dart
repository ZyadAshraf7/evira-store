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
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addOrder(List<Product>orderProducts , UserModel user){
    final DocumentReference orderDoc = _firestore.collection("order").doc(UserPreferences.getUserEmail()).collection("userOrders").doc();
    OrderModel order =
        OrderModel(orderId: orderDoc.id, orderProducts: orderProducts, user: user);
    orderDoc.set(order.toJson());
  }
}
