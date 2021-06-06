
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/shopping_cart_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Models/products.dart';
import 'package:shop_cart_tav_flutter/Models/shopping_cart.dart';

class ShoppingCartController extends GetxController {

  List<ShoppingCart> cartList = [];

  final ShoppingCartRepository shoppingCartRepository;
  ShoppingCartController({this.shoppingCartRepository});

 final ProductsController productsController = Get.put(ProductsController(repository: ProductRepository()));
 final UserController userController = Get.put(UserController(userRepository: UserRepository()));


 Products editQtyfuck;



  void serializer(List<dynamic> data){
    cartList =[];
    for (var item in data) {
      cartList.add(ShoppingCart.fromJson(item));
    }
    update();
  }

  void getShoppingCart() async {
       await shoppingCartRepository.getShoppingCart().then((value) => serializer(value.data as List<dynamic>));
  }

  isProductCart(Products products)=>
      cartList.where((element) => element.product.id == products.id).toList().isNotEmpty;

  void deleteCart(Products products)async{
    await shoppingCartRepository.deleteShoppingCart(getCartByProduct(products)).then((value) => getShoppingCart());
  }

  void addCart(Products addproducts){
    if(!isProductCart(addproducts)){
      ShoppingCart shopCart = ShoppingCart(
        product: addproducts,userId: userController.loggedInUser.id,quantity: 1
      );
      shoppingCartRepository.addShoppingCart(shopCart).then((value){getShoppingCart();});
    }
  }

  int getCartByProduct(Products searchProducts){
    int foundId = 0;
    cartList.forEach((element) {
      if(element.product.id == searchProducts.id &&
      element.userId == userController.loggedInUser.id)
        foundId = element.id;
    });
    return foundId;
  }


  void removeCart(int id)async{
    await shoppingCartRepository.deleteShoppingCart(id).then((value) => getShoppingCart());
  }

  Future<void> updateCart(ShoppingCart products, int qty )  async{
    shoppingCartRepository.editShoppingCart(products).then((value) => getShoppingCart());
}

int calculateTotal(){
  int totalCalculate = 0;
  cartList.forEach((element) {totalCalculate += element.quantity * element.product.price;});
  return totalCalculate;
}

}



// void edit(ShoppingCart editShoppingCart)async {
//   shoppingCartRepository.editShoppingCart(editShoppingCart).then((value) => getShoppingCart());
//
// }
//
// void delete(int id)async{
//   shoppingCartRepository.deleteShoppingCart(id).then((value)=>getShoppingCart());
// }
// void post( addShoppingCart) async{
//   shoppingCartRepository.addShoppingCart(addShoppingCart).then((value)=>getShoppingCart());
//
// }
//
// addToCart(ShoppingCart product ) {
//   int index = cartList.indexWhere((i) => i.id == product.id);
//   if (index != -1) {
//     updateCart(product, 1);
//   }
//   else {
//     post(product);
//     calculateTotal();
//   }
// }
//
// void removeCart(ShoppingCart product) {
//   int index = cartList.indexWhere((i) => i.id == product.id);
//   cartList[index].quantity = 1;
//   delete(cartList[index].id);
//   calculateTotal();
// }
//
//
// void updateCart(ShoppingCart product, qty ) async{
//   int index = cartList.indexWhere((i) => i.id == product.id);
//   if(cartList[index].quantity < productsController.productList[index].quantity) {
//     if(cartList[index].quantity > 0 ) {
//       cartList[index].quantity = qty;
//
//       if(cartList[index].quantity == 0)
//         delete(cartList[index].id);
//
//       calculateTotal();
//       edit(cartList[index]);
//     }
//   }
// }
//
//
// int calculateTotal(){
//   int totalCalculate = 0;
//   cartList.forEach((element) {totalCalculate += element.quantity * element.product.price;});
//   return totalCalculate;
// }
//
// void clearCart() {
//   cartList.forEach((element) {
//     element.quantity -= element.quantity;
//     removeCart(element);
//   });
//
// }