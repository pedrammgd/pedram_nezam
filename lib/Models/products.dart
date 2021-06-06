import 'package:shop_cart_tav_flutter/Models/tags.dart';

class Products {
  Products({
    this.id,
    this.title,
    this.description,
    this.price,
    this.quantity,
    this.isActive,
    this.img,
    this.productTags,



  });

  int id;
  String title;
  String description;
  int price;
  int quantity;
  String img;
  bool isActive;

  List<TagsProduct> productTags;
  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
    isActive: json["isActive"],

    img: json["img"],
    productTags: (json['productTags'] as List<dynamic>)
        .map((e) => TagsProduct.fromJson(e))
        .toList(),

  );


  String toString() {
    return '{$id,$title,$price,$productTags}';
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description":description,
    "price":price,
    "quantity":quantity,
    "isActive":isActive,

    "img":img,
    "productTags": productTags.map((e) => e.toJson()).toList()
  };
}