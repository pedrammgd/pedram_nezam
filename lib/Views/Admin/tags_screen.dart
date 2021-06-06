import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/tag_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/tags_controller.dart';
import 'package:shop_cart_tav_flutter/Views/add_edit_tag.dart';

class TagsScreen extends StatelessWidget {

  TagsController _tagsController()=>Get.find<TagsController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(child: _tagBody()),
      floatingActionButton: _addTagButton(),
    );
  }

  Widget _addTagButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        initializeAdd();
        await Get.to(addEditTag(
          edit: false,
        ));
      },
    );
  }

  Widget _tagBody() {
    return GetBuilder<TagsController>(
      init: TagsController(tagRepository: TagRepository()),
      initState: (state) => _tagsController().getTags(),
      builder: (_) {
        return _tagsController().tagList.isEmpty
            ? listViewEmpty()
            : ListView.builder(
                itemCount: _tagsController().tagList.length,
                itemBuilder: (context, index) {
                  _tagsController().tagsProduct = _tagsController().tagList[index];
                  return ListTile(
                    leading: Icon(Icons.local_offer_outlined),
                    trailing: _editTagButton(index),
                    onLongPress: () {
                      _deleteTag(index);
                    },
                    title: _tagTitle(index),
                  );
                },
              );
      },
    );
  }

  Widget _tagTitle(int index) => Text(_tagsController().tagList[index].tagName);

  Future _deleteTag(int index) {
    return Get.defaultDialog(
      title: 'DeleteTag',
      middleText:
          'Are you sure Delete : ${_tagsController().tagList[index].tagName}',
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('No')),
        TextButton(
            onPressed: () {
              _tagsController().deleteTag(_tagsController().tagList[index].id);
              Get.back();
            },
            child: Text('Ok Delete'))
      ],
    );
  }

  Widget _editTagButton(int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () async {
        initializeEdit(index);
        await Get.to(addEditTag(edit: true));
      },
    );
  }

  Widget listViewEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 100,
            color: Colors.red,
          ),
          Text('Tags Is Empty')
        ],
      ),
    );
  }

  void initializeEdit(index) {
    _tagsController().tagsProduct = _tagsController().tagList[index];
    _tagsController().tagsEditController.text =
        _tagsController().tagList[index].tagName;
  }

  void initializeAdd() {
    _tagsController().tagsEditController.text = '';
  }
}
