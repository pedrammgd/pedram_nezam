import 'package:dio/dio.dart' as dio;
import 'package:shop_cart_tav_flutter/Models/products.dart';
import 'package:shop_cart_tav_flutter/Other/Configs/backend_config.dart';

class ProductRepository{

  Future<dio.Response> getProduct()async =>
      await BackendConfig.dio.get('/products');

  Future<dio.Response> findProduct(String queryParams) async =>
      await BackendConfig.dio.get('/products?$queryParams');

  Future<dio.Response> editProduct(Products editProduct) async =>
      await BackendConfig.dio.put('/products/${editProduct.id}' , data: editProduct.toJson());

  Future<dio.Response> addProduct(Products addProduct)async =>
      await BackendConfig.dio.post('/products' , data: addProduct.toJson()).catchError((error){
        print(error);
      });

  Future<dio.Response> removeProduct(int id)async =>
      await BackendConfig.dio.delete('/products/$id').catchError((error){
        print(error);
      });
    
    
  
}