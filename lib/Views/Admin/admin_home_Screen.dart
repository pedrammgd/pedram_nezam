import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:get/get.dart';
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

import 'package:shop_cart_tav_flutter/Views/Widgets/add_edit_product.dart';

class AdminHomeScreen extends StatelessWidget {

  ProductsController _controller()=> Get.find<ProductsController>();

  final ProductPartController productPartController =
      Get.put(ProductPartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyAdminHome(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          _initializeAdd();
          await Get.to(AddEditProduct());
        },
      ),
    );
  }

  Widget _bodyAdminHome() {
    return GetBuilder<ProductsController>(
        initState: (_) => _controller().getProducts(),
        builder: (_) {
          return _gridBody();
        });
  }

  Widget _gridBody() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (1 / 2), crossAxisCount: 2),
      itemCount: _controller().productList.length,
      itemBuilder: (context, index) {
        productPartController.editModeProdct =
            _controller().productList[index];
        return _cardAdmin(index);
      },
    );
  }

  Widget _cardAdmin(int index) {
    return Card(
      child: Column(
        children: [
          _imageCard(index),
          ListTile(
            trailing: _editButton(index),
            title: _titleProduct(index),
          ),
          Row(
            children: [
              _priceProduct(index),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            children: [
              _quantityProduct(index),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          _tags(index)
        ],
      ),
    );
  }

  Widget _tags(int index) {
    return Tags(
      itemCount: _controller().productList[index].productTags.length,
      itemBuilder: (int tagIndex) {
        print(
            'tagIndex is ${_controller().productList[index].productTags.length}');
        return Tooltip(
            message: _controller()
                .productList[index].productTags[tagIndex].tagName,
            child: ItemTags(
              index: tagIndex,
              title: _controller()
                  .productList[index].productTags[tagIndex].tagName,
            ));
      },
    );
  }

  Widget _quantityProduct(int index) {
    return Text('quantity: ${_controller().productList[index].quantity}');
  }

  Widget _priceProduct(int index) {
    return Text('price: ${_controller().productList[index].price}');
  }

  Widget _titleProduct(int index) {
    return Text(
      _controller().productList[index].title,
    );
  }

  Widget _editButton(int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () async {
        _initializeEdit(index);
        await Get.to(AddEditProduct(
          edit: true,
        ));
      },
    );
  }

  Widget _imageCard(int index) {
    return Container(
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: _deleteProduct(index),
          )),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: _controller().productList[index].img == ''
                ? AssetImage('assets/noImage.png')
                : FileImage(File(_controller().productList[index].img))),
      ),
    );
  }

  void _initializeEdit(index) {
    productPartController.editModeProdct =
        _controller().productList[index];
    productPartController.titleEditingController.text =
        _controller().productList[index].title;
    productPartController.descriptionEditingController.text =
        _controller().productList[index].description;
    productPartController.quantityEditingController.text =
        _controller().productList[index].quantity.toString();
    productPartController.priceEditingController.text =
        _controller().productList[index].price.toString();
    productPartController.selectImagePath.value =
        _controller().productList[index].img;
    productPartController.productTag =
        _controller().productList[index].productTags;
    productPartController.isActive.value =
        _controller().productList[index].isActive;
  }

  void _initializeAdd() {
    productPartController.titleEditingController.text = '';
    productPartController.descriptionEditingController.text = '';
    productPartController.quantityEditingController.text = '';
    productPartController.priceEditingController.text = '';
    productPartController.selectImagePath.value = '';
    productPartController.productTag = [];
    productPartController.isActive.value = true;
  }

  Widget _deleteProduct(int index) {
    return IconButton(
      icon: Icon(
        Icons.delete_outline,
        color: Colors.red,
        size: 30,
      ),
      onPressed: () {
        Get.defaultDialog(
            title: 'Delete Product',
            middleText:
                'Are you sure delete : ${_controller().productList[index].title}',
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('No')),
                  TextButton(
                      onPressed: () {
                        _controller().deleteProduct(
                            _controller().productList[index].id);
                        Get.back();
                      },
                      child: Text(
                        'Ok Delete',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            ]);
      },
    );
  }
}
