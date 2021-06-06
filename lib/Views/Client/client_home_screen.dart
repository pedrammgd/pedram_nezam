import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/favorite_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/favorite_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/shopping_cart_controller.dart';



class HomeScreen extends StatelessWidget {

  ProductsController _productsController()=> Get.find<ProductsController>();
  FavoriteController _favoriteController()=>Get.find<FavoriteController>();
  ShoppingCartController _shoppingCartController()=>Get.find<ShoppingCartController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyClientHome(),
    );
  }

  Widget _bodyClientHome() {
    return GetBuilder<ProductsController>(
        init: ProductsController(repository: ProductRepository()),
        initState: (_) => _productsController().getProducts(),
        builder: (_) {
          return _gridBody();
        });
  }

  GridView _gridBody() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (1 / 2), crossAxisCount: 2),
      itemCount: _productsController().productList.length,
      itemBuilder: (context, index) {
        _shoppingCartController().editQtyfuck =
            _productsController().productList[index];
        return _cardBody(context, index);
      },
    );
  }

  Card _cardBody(BuildContext context, int index) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Column(
          children: [
            _imageProduct(index),
            ListTile(
              enabled:
                  _productsController().productList[index].isActive ? true : false,
              title: _titleProduct(index),
              subtitle: _descriptipnProduct(index),
            ),
            _priceProduct(index),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GetBuilder(
                init:FavoriteController(favoriteRepository: FavoriteRepository()),
                initState: (state) => _favoriteController().getFavorites(),
                builder: (_) {
                  return
                   _favoriteController().isProductFavorite(
                          _productsController().productList[index])
                          ? IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            _favoriteController().deleteFavorite(
                                _productsController().productList[index]);
                          })
                          : IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {
                            _favoriteController().addFavorite(
                                _productsController().productList[index]);
                          });

                }
                ),


                _buyingButton(index),
              ],
            ),
            _tagProduct(index),
          ],
        ),
      ),
    );
  }

  Text _descriptipnProduct(int index) =>
      Text('${_productsController().productList[index].description}');

  Widget _tagProduct(int index) {
    return Tags(
      columns: 4,
      itemCount: _productsController().productList[index].productTags.length,
      itemBuilder: (int tagIndex) {
        print(
            'tagIndex is ${_productsController().productList[index].productTags.length}');

        return Tooltip(
            message: _productsController()
                .productList[index].productTags[tagIndex].tagName,
            child: ItemTags(
              padding: EdgeInsets.all(0),
              index: tagIndex,
              title: _productsController()
                  .productList[index].productTags[tagIndex].tagName,
            ));
      },
    );
  }

  Widget _buyingButton(int index) {
    return IconButton(
      icon: Icon(Icons.shopping_bag_outlined),
      onPressed: () {
        _shoppingCartController().addCart(_productsController().productList[index]);
        print('${_productsController().productList[index]}');
      },
    );
  }

  Widget _priceProduct(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('price: ${_productsController().productList[index].price}'),
        _productsController().productList[index].quantity == 0
            ? Text(
                'Lack of inventory',
                style: TextStyle(fontSize: 12, color: Colors.amber),
              )
            : Container(),
      ],
    );
  }

  Widget _titleProduct(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _productsController().productList[index].title,
        ),
        _productsController().productList[index].quantity < 5
            ? Text(
                'Less than 5',
                style: TextStyle(fontSize: 13, color: Colors.red),
              )
            : Container()
      ],
    );
  }

  Widget _imageProduct(int index) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: _productsController().productList[index].img == ''
                ? AssetImage('assets/noImage.png')
                : FileImage(File(_productsController().productList[index].img))),
      ),
    );
  }
}
