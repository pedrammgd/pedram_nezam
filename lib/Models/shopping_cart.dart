import 'package:shop_cart_tav_flutter/Models/products.dart';
class ShoppingCart {
  ShoppingCart({
    this.id,
    this.product,
    this.quantity ,
    this.userId,
  });

  int id;
  int quantity;
  Products product;
  int userId;

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
    id: json["id"],
    quantity: json["quantity"],
    product:Products.fromJson(json["product"]),
    userId:json["userId"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity":quantity,
    "product": product,
    "userId":userId,
  };
}