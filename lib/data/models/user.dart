import 'package:evira_store/data/models/product.dart';

class UserModel {
  String? idToken;
  String? name;
  String? imageUrl;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? refreshToken;
  List<Product>? favouriteProducts;
  List<Product>? cartProducts;

  UserModel(
      {this.idToken,
      this.name,
      this.imageUrl,
      this.email,
      this.password,
      this.phoneNumber,
      this.address,
      this.refreshToken,
      this.favouriteProducts,
      this.cartProducts});

  UserModel.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    refreshToken = json['refreshToken'];
    if (json['favouriteProducts'] != null) {
      favouriteProducts = <Product>[];
      json['favouriteProducts'].forEach((v) {
        favouriteProducts!.add(Product.fromJson(v));
      });
    }
    if (json['cartProducts'] != null) {
      cartProducts = <Product>[];
      json['cartProducts'].forEach((v) {
        cartProducts!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['idToken'] = idToken;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    // data['refreshToken'] = refreshToken;
    if (favouriteProducts != null) {
      data['favouriteProducts'] =
          favouriteProducts!.map((v) => v.toJson()).toList();
    }
    if (cartProducts != null) {
      data['cartProducts'] = cartProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



