import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evira_store/data/models/product.dart';
import 'package:evira_store/data/shared_preference/user_preference.dart';
import 'package:meta/meta.dart';

part 'favourite_products_state.dart';

class FavouriteProductsCubit extends Cubit<FavouriteProductsState> {
  FavouriteProductsCubit() : super(FavouriteProductsInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product>favouriteProducts = [];
  fetchUserFavouriteProducts()async{
    emit(FavouriteProductsLoading());
    try{
      final document = await _firestore.collection("users").doc(UserPreferences.getUserEmail()).get();
      List<dynamic> favouriteProductResponse = document.get("favouriteProducts");
      favouriteProducts = favouriteProductResponse.map((e) => Product.fromJson(e)).toList();
      if(favouriteProducts.isNotEmpty){
        emit(FavouriteProductsDone());
      }
    }catch(e){
      emit(FavouriteProductsFailed());
      print(e);
    }
  }

  addProductToFavourite(Product product){
    favouriteProducts.insert(0, product);
    emit(AddProductToFavourite());
    _firestore
        .collection('users')
        .doc(UserPreferences.getUserEmail())
        .update({
      'favouriteProducts': FieldValue.arrayUnion([product.toJson()])
    });
  }
  removeProductFromFavourite(Product product){
    favouriteProducts.removeWhere((element) => element.id==product.id);
    emit(RemoveProductToFavourite());
    _firestore
        .collection('users')
        .doc(UserPreferences.getUserEmail())
        .update({
      'favouriteProducts': FieldValue.arrayRemove([product.toJson()])
    });
  }
  toggleProductsToFavorite(Product product)async{
    try {
      if ((checkIfProductFavourite(product))) {
        //PRODUCT EXIST
        removeProductFromFavourite(product);
      } else {
        //PRODUCT DOES NOT EXIST
        addProductToFavourite(product);
      }
    }catch(e){
      print(e.toString());
    }
  }
   bool checkIfProductFavourite(Product product){
    try {
      /*final document = await _firestore.collection('users').doc(
          UserPreferences.getUserEmail()).get();
      final List<dynamic> myProducts = document.data()!['favouriteProducts'];
      final List<Products> userProducts = myProducts.map((e)=>Products.fromJson(e)).toList();*/
      final bool isExist = favouriteProducts.any((element) => element.id==product.id);
      if (isExist) {
        return true;
      } else {
        return false;
      }
    }catch(e){
      print(e.toString());
      return false;
    }
  }
}
