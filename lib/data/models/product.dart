class Product {
  int? id;
  String? title;
  String? description;
  num? price;
  Rating? rating;
  String? category;
  String? image;
  int? quantity;

  Product(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.rating,
        this.category,
        this.image,this.quantity=1});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'].toDouble();
    rating =  rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    category = json['category'];
    image = json['image'];
    quantity = json['quantity']??1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['category'] = this.category;
    data['image'] = this.image;
    data['quantity'] = this.quantity??1;
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'].toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}