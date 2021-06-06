import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_cart_tav_flutter/Controllers/product_part_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/tag_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/tags_controller.dart';
import 'package:shop_cart_tav_flutter/Other/Widgets/custom_text_form_field.dart';

class AddEditProduct extends StatelessWidget {
  final bool edit;

  AddEditProduct({this.edit = false});



  ProductPartController _productPartController(){
    return Get.find<ProductPartController>();
  }



  TagsController _tagsController()=>Get.find<TagsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBarEdit(), body: bodyEditProduct());
  }

  Widget bodyEditProduct() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: SingleChildScrollView(
          child:  formProduct(),
        ),
      ),
    );
  }

   formProduct() {
    return Form(
      key: _productPartController().formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _imageProduct(),
          Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 5)),
              _tagSelected(),
              GetBuilder(
                  init: ProductPartController(),
                  builder: (controller) {
                    return  _tagSearch();
                  }),
            ],
          ),
          _titleProduct(),
          _descriptionProduct(),
          _priceProduct(),
          _quantityProduct(),
          _isActiveProduct(),
          ElevatedButton(
              onPressed: ()  {
                if (_productPartController().formKey.currentState.validate()) {
                   addEditButton();
                }
              },
              child: edit ? Text('edit') : Text('add')),
        ],
      ),
    );
  }

  Widget _isActiveProduct() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('is Active Product :'),
          Checkbox(
            value: _productPartController().isActive.value,
            onChanged: (value) {
              _productPartController().isActive.value = value;

              print(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _quantityProduct() {
    return CustomTextField(
      validator$: (value) {
        if (value == null || value.isEmpty) {
          return 'Quantity is Empty';
        }
        return null;
      },
      keyboardType$: TextInputType.number,
      controller$: _productPartController().quantityEditingController,
      hintText$: 'quantity',
      prefixIcon$: Icon(Icons.format_list_numbered),
    );
  }

  Widget _priceProduct() {
    return CustomTextField(
      validator$: (value) {
        if (value == null || value.isEmpty) {
          return 'Price is Empty';
        }
        return null;
      },
      keyboardType$: TextInputType.number,
      controller$: _productPartController().priceEditingController,
      hintText$: 'Price',
      prefixIcon$: Icon(Icons.attach_money_outlined),
    );
  }

  Widget _descriptionProduct() {
    return CustomTextField(
      validator$: (value) {
        if (value == null || value.isEmpty) {
          return 'Description is Empty';
        }
        return null;
      },
      contentPadding$: EdgeInsets.symmetric(vertical: 30),
      controller$: _productPartController().descriptionEditingController,
      hintText$: 'Description',
      prefixIcon$: Icon(Icons.description_outlined),
    );
  }

  Widget _titleProduct() {
    return CustomTextField(
      validator$: (value) {
        if (value == null || value.isEmpty) {
          return 'Title is Empty';
        }
        return null;
      },
      controller$: _productPartController().titleEditingController,
      hintText$: 'Title',
      prefixIcon$: Icon(Icons.title_outlined),
    );
  }

  Widget _tagSearch()  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            controller: _productPartController().tagEditingController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                prefixIcon: Icon(Icons.local_offer_outlined),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _productPartController().addNewTag();
                  },
                ))),
        suggestionsCallback: (pattern) async {
          return await onTypeTag(pattern);
        },
        itemBuilder: (context, itemData) {
          return ListTile(
            title: Text(itemData.tagName),
          );
        },
        onSuggestionSelected: (suggestion) {
          _onSuggestionTag(suggestion);
        },
      ),
    );
  }

  Obx _imageProduct() {
    return Obx(
      () => _productPartController().selectImagePath.value == ''
          ? Stack(
              children: [
                InkWell(
                  onTap: () {
                    _productPartController().getItem(ImageSource.camera);
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                      child: Center(
                          child: Icon(
                        Icons.camera_alt,
                        size: 50,
                      )),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _productPartController().getItem(ImageSource.gallery);
                    },
                  ),
                )
              ],
            )
          : Stack(
              children: [
                InkWell(
                  onTap: () {
                    _productPartController().getItem(ImageSource.camera);
                  },
                  child: Container(
                      width: 150,
                      height: 150,
                      child: ClipOval(
                        child: Image.file(
                          File(_productPartController().selectImagePath.value),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _productPartController().getItem(ImageSource.gallery);
                    },
                  ),
                )
              ],
            ),
    );
  }

  AppBar appBarEdit() => AppBar(
        title: edit ? Text('edit') : Text('add'),
      );

  Widget addEditButton() {
     _productPartController().addEditProduct(edit);
    Get.back();
  }

  Widget _tagSelected() {
    return GetBuilder<ProductPartController>(
      init: ProductPartController(),
      initState: (_) {},
      builder: (_) {
        return Tags(
          itemCount: _productPartController().productTag.length,
          itemBuilder: (int index) {
            return Tooltip(
              message: _productPartController().productTag[index].tagName,
              child: ItemTags(
                padding: EdgeInsets.all(3),
                index: index,
                title: _productPartController().productTag[index].tagName,
                removeButton: ItemTagsRemoveButton(
                  onRemoved: () {
                    _productPartController().productTag.removeAt(index);
                    _productPartController().update();
                    return true;
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<List> onTypeTag(String pattern) async {
    await _tagsController().searchTag(pattern);
    print(_tagsController().tagList);
    return _tagsController().tagList;
  }

  void _onSuggestionTag(suggestion) async {
    _productPartController().addPrductTag(suggestion);
  }
}
