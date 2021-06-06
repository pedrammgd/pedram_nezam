import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Models/products.dart';

class ProductsController extends GetxController{

  List<Products> productList = [];

  final ProductRepository repository;
  ProductsController({@required this.repository}): assert(repository !=null);


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();

  }
 void serializer(List data) {
    productList = [];
    for (var item in data) {
      productList.add(Products.fromJson(item));
    }
    update();
  }

  Future<void> getProducts()async{
    print('jhvkjgvkjhgvkjgvjhv jgvjgvj');
    await repository.getProduct().then((value) => serializer(value.data as List));
  }

  Future<void> searchProduct(String searchText)async{
    await repository.findProduct('q=$searchText').then((value) => serializer(value.data as List));
  }



  Future<void> postProduct(Products addProducts) async{
    await repository.addProduct(addProducts).then((value)async{await getProducts();});
  }
  Future<void> editProduct(Products editProduct)async{
    await repository.editProduct(editProduct).then((value)async{await getProducts();});

  }
  Future<void> deleteProduct(int id) async{
    await repository.removeProduct(id).then((value){getProducts();});
  }





}