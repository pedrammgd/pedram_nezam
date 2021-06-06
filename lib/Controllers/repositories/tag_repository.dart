
import 'package:dio/dio.dart' as dio;
import 'package:shop_cart_tav_flutter/Models/tags.dart';
import 'package:shop_cart_tav_flutter/Other/Configs/backend_config.dart';

class TagRepository{

  Future<dio.Response> getTag()async =>
      await BackendConfig.dio.get('/tags');

  Future<dio.Response> findTag(String query)async =>
      await BackendConfig.dio.get('/tags?$query');

  Future<dio.Response> addTag(TagsProduct addTag)async =>
      await BackendConfig.dio.post('/tags' , data: addTag.toJson());

  Future<dio.Response> editTag(TagsProduct editTag)async =>
      await BackendConfig.dio.put('/tags/${editTag.id}' , data: editTag.toJson());

  Future<dio.Response> removeTag(int id)async =>
      await BackendConfig.dio.delete('/tags/$id');


}