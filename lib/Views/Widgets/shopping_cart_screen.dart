import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shop_cart_tav_flutter/Controllers/repositories/shopping_cart_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/shopping_cart_controller.dart';

class ShoppingCartScreen extends StatelessWidget {

  ShoppingCartController _shoppingCartController()=>Get.find<ShoppingCartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: _bodyCart(),
    );
  }

  Widget _bodyCart() {
    return GetBuilder<ShoppingCartController>(
        init: ShoppingCartController(
            shoppingCartRepository: ShoppingCartRepository()),
        initState:(state) =>  _shoppingCartController().getShoppingCart(),
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemExtent: 120,
                  itemCount: _shoppingCartController().cartList.length,
                  itemBuilder: (context, index) {
                    return _cardCart(index);
                  },
                ),
              ),
              _totalPrice(),
              _buyButton()
            ],
          );
        });
  }

  Widget _buyButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: Text('buy'),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _totalPrice() => Container(
        padding: EdgeInsets.all(10),
        child: Text.rich(TextSpan(text: ' Total Price', children: [
          TextSpan(
              text: '  ${_shoppingCartController().calculateTotal()}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
        ])),
      );

  Card _cardCart(int index) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Container(
          height: 80,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(width: .5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: _shoppingCartController().cartList[index].product.img == ''
                    ? AssetImage('assets/noImage.png')
                    : FileImage(File(
                        _shoppingCartController().cartList[index].product.img)),
              )),
        ),
        title: _titleCart(index),

        subtitle: _subtitleCart(index),
        //
        trailing: Container(
          width: 120,
          child: Column(
            children: [
              _removeCart(index),
              Expanded(
                child: Row(
                  children: [
                    _shoppingCartController().cartList[index].quantity > 1
                        ? Expanded(
                            child: _decrementingButton(index),
                          )
                        : Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, top: 12),
                      child: quantityCart(index),
                    ),
                    _shoppingCartController().cartList[index].quantity < _shoppingCartController().cartList[index].product.quantity?
                    Expanded(child: decrementingButton(index)):Expanded(child: IconButton(icon:Icon(Icons.add_circle_outline))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget decrementingButton(int index) {
    return IconButton(
        icon: Icon(Icons.add_circle_outline,color: Colors.black,),
        onPressed: () async{
        await  _shoppingCartController().updateCart(_shoppingCartController().cartList[index]
              , _shoppingCartController().cartList[index].quantity +=1,
          );
          _shoppingCartController().update();
        });
  }

  Widget quantityCart(int index) =>
      Text('${_shoppingCartController().cartList[index].quantity}');

  Widget _decrementingButton(int index) {
    return IconButton(
        icon: Icon(Icons.remove_circle_outline ,color: Colors.black,),
        onPressed: () async{

          _shoppingCartController().updateCart(_shoppingCartController().cartList[index]
              , _shoppingCartController().cartList[index].quantity -=1,

          );
          _shoppingCartController().update();
        });
  }

  Widget _removeCart(int index) {
    return Align(
      child: IconButton(
        icon: Icon(
          Icons.clear,
          size: 20,
          color: Colors.red,
        ),
        onPressed: () {
          Get.defaultDialog(
              title: 'RemoveCart',
              middleText:
                  'Are you sure remove ${_shoppingCartController().cartList[index].product.title}',
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      _shoppingCartController().removeCart(_shoppingCartController().cartList[index].id);

                      Get.back();
                    },
                    child: Text('Yes'))
              ]);
        },
      ),
      alignment: Alignment.bottomRight,
      heightFactor: .6,
    );
  }

  Widget _subtitleCart(int index) {
    return Text(
      _shoppingCartController().cartList[index].quantity.toString() +
          "  x  " +
          _shoppingCartController().cartList[index].product.price.toString() +
          "  =  " +
          (_shoppingCartController().cartList[index].quantity *
                  _shoppingCartController().cartList[index].product.price)
              .toString(),
    );
  }

  Widget _titleCart(int index) =>
      Text(_shoppingCartController().cartList[index].product.title);
}
