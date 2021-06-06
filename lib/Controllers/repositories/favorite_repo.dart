import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Models/fav_products.dart';
import 'package:shop_cart_tav_flutter/Other/Configs/backend_config.dart';

class FavoriteRepository{
  UserController _userController()=>Get.find<UserController>();
  Future<dio.Response> getFavorites()async =>
      await BackendConfig.dio.get('/favorits?userId=${_userController().loggedInUser.id}');
  
  Future<dio.Response> findFavorite(String queryParams)async =>
      await BackendConfig.dio.get('/favorits?$queryParams&userId=${_userController().loggedInUser.id}');

  Future<dio.Response> editFavorite(FavProducts editFavorite)async =>
      await BackendConfig.dio.put('/favorits/${editFavorite.id}' , data: editFavorite.toJson());
      // await BackendConfig.dio.put('/favorits/${editFavorite.id}?userId=${_userController(.loggedInUser.id}' , data: editFavorite.toJson());

  Future<dio.Response> addFavorite(FavProducts addFavorite)async =>
      await BackendConfig.dio.post('/favorits' , data: addFavorite.toJson()).catchError((error){
        print(error);
      });

  Future<dio.Response> removeFavorite(int id)async =>
      await BackendConfig.dio.delete('/favorits/$id');
}