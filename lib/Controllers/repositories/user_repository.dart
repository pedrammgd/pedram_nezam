import 'package:dio/dio.dart' as dio;
import 'package:shop_cart_tav_flutter/Models/user.dart';
import 'package:shop_cart_tav_flutter/Other/Configs/backend_config.dart';

class UserRepository{
  
  
  Future<dio.Response> getUser()async =>
      await BackendConfig.dio.get('/users');



  Future<dio.Response> finUser(String queryParams)async =>
      await BackendConfig.dio.get('/users?$queryParams');

  Future<dio.Response> editUser(User edituser)async =>
      await BackendConfig.dio.put('/users/${edituser.id}' , data: edituser.toJson());

  Future<dio.Response> addUser(User addUser)async =>
      await BackendConfig.dio.post('/users' , data: addUser.toJson()).catchError((error){
        print(error);
      });

  Future<dio.Response> deleteUser(int id)async =>
      await BackendConfig.dio.delete('/users/$id');
}