// import 'package:shop_cart_tav_flutter/Models/products.dart';
// import 'package:shop_cart_tav_flutter/Models/user.dart';
//
// class FavProducts {
//   FavProducts({
//     this.id,
//     this.product,
//     this.user,
//   });
//
//   int id;
//   Products product;
//   Users user;
//   factory FavProducts.fromJson(Map<String, dynamic> json) => FavProducts(
//     id: json["id"],
//     product:Products.fromJson(json["product"]),
//     user:Users.fromJson(json["fav"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product": product,
//     "user": user,
//   };
// }

// extension favoriteJson on FavProducts{
//   Map<String, dynamic> toJson(){
//     return{
//       'product':this.product.toJson(),
//       'user':this.user.toJson()
//     };
//   }
// }




import 'package:shop_cart_tav_flutter/Models/products.dart';
import 'package:shop_cart_tav_flutter/Models/user.dart';

class FavProducts {
  FavProducts({
    this.id,
    this.liked = false,
    this.product,
    this.userId
  });

  int id;
  bool liked;
  Products product;
  int userId;

  factory FavProducts.fromJson(Map<String, dynamic> json) => FavProducts(
    id: json["id"],
    liked: json["liked"],
    product:Products.fromJson(json["product"]),
    userId: json["userId"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "liked":liked,
    "product": product,
    "userId":userId
  };
}