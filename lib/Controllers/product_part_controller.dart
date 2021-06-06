import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/product_repo.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/tag_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/tags_controller.dart';
import 'package:shop_cart_tav_flutter/Models/products.dart';
import 'package:shop_cart_tav_flutter/Models/tags.dart';

class ProductPartController extends GetxController{

  final TextEditingController tagEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController quantityEditingController = TextEditingController();
  final ProductsController productsController =Get.put(ProductsController(repository: ProductRepository()));
  final formKey = GlobalKey<FormState>();

 final TagsController tagsController = Get.put(TagsController(tagRepository: TagRepository()));


  List<TagsProduct> productTag = [];

  RxBool isActive = true.obs;
  Products editModeProdct;
  var selectImagePath = ''.obs;

  void getItem(ImageSource imageSource) async{

    final pickFile = await ImagePicker().getImage( source: imageSource);
    if(pickFile != null){
      selectImagePath.value = pickFile.path;
    }else{

      Get.snackbar('Error', 'No Image selected', snackPosition:SnackPosition.BOTTOM);
    }
  }

   void addNewTag()  {
    if (tagsController
        .tagList
        .where((element) => element.tagName == tagEditingController.text).toList().isEmpty && tagEditingController.text != '') {
      TagsProduct newTag = TagsProduct(tagName: tagEditingController.text);
      tagsController.addTag(newTag);
    }
  }

 void addEditProduct(bool edit){
    if(edit){
      Products editProduct = Products(
        id: editModeProdct.id,
        title: titleEditingController.text,
        description: descriptionEditingController.text,
        img: selectImagePath.value,
        productTags: productTag,
        isActive: isActive.value,
        price: int.parse(priceEditingController.text),
        quantity: int.parse(quantityEditingController.text),);
      productsController.editProduct(editProduct);
      productsController.getProducts();
    }
    else {
      Products addProducts = Products(
        title: titleEditingController.text,
        description: descriptionEditingController.text,
        img: selectImagePath.value,
        productTags: productTag,
        isActive: isActive.value,
        price: int.parse(priceEditingController.text),
        quantity: int.parse(quantityEditingController.text),);
      productsController.postProduct(addProducts);
    }
  }


  void addPrductTag(TagsProduct newTag) {
    if (productTag
        .where((element) => element.id == newTag.id)
        .toList()
        .isEmpty) {
      productTag.add(newTag);
      tagEditingController.text = newTag.tagName;
    }
      update();
  }
}