import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/tag_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/tags_controller.dart';
import 'package:shop_cart_tav_flutter/Models/tags.dart';
import 'package:shop_cart_tav_flutter/Other/Widgets/custom_text_form_field.dart';

class addEditTag extends StatelessWidget {
  final bool edit;

  addEditTag({this.edit = false});

  TagsController _tagsController()=>Get.find<TagsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:edit ?Text('EditTag'):Text('addTag'),),
      body: Form(
        key: _tagsController().formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textFormTag(),
              _addEditButton()
            ],
          ),
      ),

    );
  }

  Widget _addEditButton() {
    return ElevatedButton(
                onPressed: () {
                  if(_tagsController().formKey.currentState.validate()) {
                    _tagsController().addOrEditTag(edit);
                    Get.back();
                  }
            }, child:edit? Text('edit'):Text('add'));
  }

  Widget _textFormTag() {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(validator$: (value){
                if(value == null || value.isEmpty){
                  return 'Tag is Empty';
                }
                return null;
              },prefixIcon$: Icon(Icons.local_offer_outlined),  hintText$: 'TagName', controller$:_tagsController().tagsEditController,),
            );
  }
}
