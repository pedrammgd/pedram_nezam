import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/favorite_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Models/fav_products.dart';
import 'package:shop_cart_tav_flutter/Models/products.dart';

class FavoriteController extends GetxController{


  final FavoriteRepository favoriteRepository;
  FavoriteController({this.favoriteRepository});

  ProductsController productsController = Get.put(ProductsController(repository: ProductRepository()));
  UserController userController =Get.put(UserController(userRepository: UserRepository()));
   List favList =[];




 void serializer(List<dynamic> data){
    favList  = [];
    for (var item in data) {
     favList.add(FavProducts.fromJson(item)); 
    }
    update();
  }
  void getFavorites()async{
    await favoriteRepository.getFavorites().then((value) => serializer(value.data as List<dynamic>));
  }
  
  void searchFavorite(String searchText)async{
    await favoriteRepository.findFavorite('q=$searchText').then((value) => serializer(value.data as List));
  }
  
  isProductFavorite(Products products)=>
      favList.where((element) => element.product.id == products.id)
      .toList().isNotEmpty;
  
  void deleteFavorite(Products products)async{
    await favoriteRepository.removeFavorite(getFavoriteByIdProduct(products))
        .then((value) =>getFavorites());

  }
  int getFavoriteByIdProduct(Products searchProduct){
    int foundId = 0;
    favList.forEach((element) {
      if(element.product.id == searchProduct.id &&
      element.userId == userController.loggedInUser.id)
      foundId = element.id;
    });
    return foundId;
  }

  void addFavorite(Products addFavorite){
    if(!isProductFavorite(addFavorite)){
      FavProducts myFav = FavProducts(
        product: addFavorite,userId: userController.loggedInUser.id
      );
      favoriteRepository.addFavorite(myFav).then((value){ getFavorites();});
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  //   isFavorite(FavProducts product){
  //   int index = favList.indexWhere((i) => i.id == product.product.id);
  //   if (index != -1){
  //     deleteFavorite(product);
  //
  //   }else {
  //     addFavorite(product);
  //   }
  //
  // }
  // void deleteFavorite(FavProducts product)async{
  //   await favoriteRepository.removeFavorite(product.id).then((value) => value.data);
  //   getFavorites();
  // }
  // void addFavorite(FavProducts product) async{
  //   await favoriteRepository.addFavorite(product).then((value) => value.data);
  //   getFavorites();
  // }


 
}

