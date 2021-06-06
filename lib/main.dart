import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_cart_tav_flutter/Controllers/app_bar_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/favorite_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/product_part_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/favorite_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/shopping_cart_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/tag_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/shopping_cart_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/tags_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Views/User/splash_screen.dart';

void main() async{
  await GetStorage.init();
  Get.put(ProductsController(repository: ProductRepository()));
  Get.put(FavoriteController(favoriteRepository: FavoriteRepository()));
  Get.put(TagsController(tagRepository: TagRepository()));
  Get.put(ShoppingCartController(shoppingCartRepository: ShoppingCartRepository()));
  Get.put(UserController(userRepository: UserRepository()));
  Get.put(ProductPartController());
  Get.put(AppBarController());
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
