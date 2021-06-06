import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/favorite_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/favorite_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/shopping_cart_controller.dart';
import 'package:shop_cart_tav_flutter/Models/fav_products.dart';
import 'package:shop_cart_tav_flutter/Models/shopping_cart.dart';

class FavoriteScreen extends StatelessWidget {


  FavoriteController _favoriteController()=>Get.find<FavoriteController>();
  ProductsController _productsController()=> Get.find<ProductsController>();
  ShoppingCartController _shoppingCartController()=>Get.find<ShoppingCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _bodyFavorite());
  }

 Widget _bodyFavorite() {
    return GetBuilder(
          init: FavoriteController(favoriteRepository: FavoriteRepository()),
          initState:(_) =>  _favoriteController().getFavorites(),
          builder: (_) {
            return _favoriteController().favList.isEmpty
                ? listViewEmpty()
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1/2),
                crossAxisCount: 2
              ),
                    itemCount: _favoriteController().favList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Column(
                            children: [
                              _imageProduct(index),
                              ListTile(

                                enabled: _productsController().productList[index].isActive ? true: false,
                                title: _titleProduct(index),
                                subtitle: _descriptionProduct(index),
                              ),
                              _priceProduct(index),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  _productsController().productList[index].isActive == false || _productsController().productList[index].quantity == 0 ?
                                  IconButton(icon:Icon(Icons.shopping_bag_outlined), onPressed: null):_buyingButton(index),
                                ],
                              ),

                              _tagProduct(index),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          });
  }

 Widget _descriptionProduct(int index) => Text('${_favoriteController().favList[index].product.description}');
  Widget _imageProduct(int index) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration( image: DecorationImage(fit: BoxFit.fill,
          image:_favoriteController().favList[index].product.img  ==''? AssetImage('assets/noImage.png'): FileImage( File(
              _favoriteController().favList[index].product.img))
      )
        ,),);
  }
  Widget _titleProduct(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_favoriteController().favList[index].product.title,),
        _favoriteController().favList[index].product.quantity <5 ?Text('Less than 5',style: TextStyle(fontSize: 13,color: Colors.red),):Container()
      ],
    );
  }
  Widget _priceProduct(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text('price: ${_favoriteController().favList[index].product.price}'),
        _favoriteController().favList[index].product.quantity == 0 ?  Text('Lack of inventory' ,style: TextStyle(fontSize: 12,color: Colors.amber),):Container(),
      ],

    );
  }
  Widget _tagProduct(int index) {
    return Tags(
      columns: 4,
      itemCount: _favoriteController().favList[index].product.productTags.length,

      itemBuilder: (int tagIndex) {

        return Tooltip(
            message: _favoriteController().favList[index].product.productTags[tagIndex].tagName,
            child: ItemTags(
              padding: EdgeInsets.all(0),
              index: tagIndex,
              title: _favoriteController().favList[index].product.productTags[tagIndex].tagName,

            ));
      },);
  }
  Widget _buyingButton(int index) {
    return IconButton(icon: Icon(Icons.shopping_bag_outlined),
      onPressed: () {
        // _shoppingCartController().addToCart( ShoppingCart(
        //     product: _productsController().productList[index],
        //     id: _productsController().productList[index].id,
        //     quantity: 1
        // ));
      },
    );
  }


  Widget listViewEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.red,
          ),
          Text('Favorite Is Empty')
        ],
      ),
    );
  }
}
