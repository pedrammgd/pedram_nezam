import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/tag_repository.dart';
import 'package:shop_cart_tav_flutter/Models/tags.dart';

class TagsController extends GetxController {

  List<TagsProduct> tagList = [];

  final TextEditingController tagsEditController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TagsProduct tagsProduct;

  final TagRepository  tagRepository;
  TagsController({this.tagRepository});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTags();
  }

  void serializer(List data){
    tagList  = [];
    for (var item in data) {
      tagList.add(TagsProduct.fromJson(item));
    }
    update();
  }

  void getTags() async {
    tagRepository.getTag().then((value) => serializer(value.data as List));

  }

  void searchTag(String searchText)async{
    await tagRepository.findTag('q=$searchText').then((value) => serializer(value.data as List));

  }
  void addTag(TagsProduct addTag)async{
    await tagRepository.addTag(addTag).then((value) => getTags());
  }
  void deleteTag(int id)async{
    await tagRepository.removeTag(id).then((value) => getTags());
  }
  void editTag(TagsProduct editTag)async{
    await tagRepository.editTag(editTag).then((value) =>  getTags());
  }



  void addOrEditTag(bool edit){
    if(edit){
      TagsProduct editedTag = TagsProduct(
        id: tagsProduct.id,
        tagName: tagsEditController.text
      );
      editTag(editedTag);
    }else{

      TagsProduct addedTag = TagsProduct(
          tagName: tagsEditController.text
      );
      addTag(addedTag);
    }
  }
}