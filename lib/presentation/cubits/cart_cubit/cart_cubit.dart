import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> cartList = [];
  String cart = "Cart Screen";

  fetchUserCart() async {
    emit(CartProductsLoading());
    final document = await _firestore
        .collection("users")
        .doc(UserPreferences.getUserEmail())
        .get();
    final List<dynamic> productsData = document.get("cartProducts");
    cartList = productsData.map((e) => Product.fromJson(e)).toList();
    if (cartList.isNotEmpty) {
      emit(CartProductsDone());
    }else{
      emit(CartProductsEmpty());
    }
  }

  addProductToCart(Product product) {
    cartList.insert(0, product);
    _firestore.collection("users").doc(UserPreferences.getUserEmail()).update({
      "cartProducts": FieldValue.arrayUnion([product.toJson()]),
    });
  }

  removeProductFromCart(Product product) {
    cartList.removeWhere((element) => element.id == product.id);
    _firestore.collection("users").doc(UserPreferences.getUserEmail()).update(
        {
          "cartProducts":FieldValue.arrayRemove([product.toJson()]),
        });
    emit(RemoveProductFromCart());
  }

  incrementProductQuantity(Product product) {
    product.quantity = product.quantity! + 1;

    emit(IncrementQuantity());
  }

  decrementProductQuantity(Product product) {
    if(product.quantity!>1){
      product.quantity=product.quantity!-1;
    }
    emit(DecrementQuantity());
  }
  double totalPrice = 0;
  double calculateTotalPrices(){
    totalPrice = 0;
    for (var element in cartList) {
      totalPrice+=(element.price!*element.quantity!);
    }
    totalPrice.toDouble();
    // emit(TotalPriceChange());
    return totalPrice;
  }

  Future<void> clearCart()async{
    cartList.clear();
    await _firestore.collection("users").doc(UserPreferences.getUserEmail()).update(
        {
          "cartProducts":[]
        });
    emit(ClearCart());
  }
}
