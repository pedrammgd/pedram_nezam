import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Models/shopping_cart.dart';
import 'package:shop_cart_tav_flutter/Other/Configs/backend_config.dart';

class ShoppingCartRepository{
  UserController _userController()=>Get.find<UserController>();
  Future<dio.Response>  getShoppingCart()async =>
      await BackendConfig.dio.get('/shoppingCart?userId=${_userController().loggedInUser.id}');

  Future<dio.Response> addShoppingCart(ShoppingCart addShoppingCart)async =>
      // await BackendConfig.dio.post('/shoppingCart' , data:addShoppingCart.toJson()).catchError((error){
      await BackendConfig.dio.post('/shoppingCart?userId=${_userController().loggedInUser.id}' , data:addShoppingCart.toJson()).catchError((error){
        print(error);
      });

  Future<dio.Response> editShoppingCart(ShoppingCart editShoppingCart)async =>
      // await BackendConfig.dio.put('/shoppingCart/${editShoppingCart.id}' , data: editShoppingCart.toJson()).catchError((error){
      await BackendConfig.dio.put('/shoppingCart/${editShoppingCart.id}?userId=${_userController().loggedInUser.id}' , data: editShoppingCart.toJson()).catchError((error){
        print(error);
      });

  Future<dio.Response> deleteShoppingCart(int id)async =>
      await BackendConfig.dio.delete('/shoppingCart/$id').catchError((error){
        print(error);
      });
}