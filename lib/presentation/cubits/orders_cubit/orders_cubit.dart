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

  Future<void> addOrder(
      {required List<Product> orderProducts,
      required UserModel user,
      required double subTotal,
      required double shipping,
      required double discount,
      required double total}) async {
    try {
      final DocumentReference orderDoc = _firestore
          .collection("orders")
          .doc(UserPreferences.getUserEmail())
          .collection("userOrders")
          .doc();
      OrderModel order = OrderModel(
          orderId: orderDoc.id,
          orderProducts: orderProducts,
          user: user,
          subTotal: subTotal,
          shipping: shipping,
          discount: discount,
          total: total);
      await orderDoc.set(order.toJson());
    }catch(e){
      print(e.toString());
    }
  }
}
