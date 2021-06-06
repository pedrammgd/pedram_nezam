import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_cart_tav_flutter/Controllers/app_bar_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/favorite_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/products_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/shopping_cart_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/shopping_cart_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/tags_controller.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Other/Widgets/search_bar.dart';
import 'package:shop_cart_tav_flutter/Views/Admin/admin_home_Screen.dart';
import 'package:shop_cart_tav_flutter/Views/Admin/tags_screen.dart';
import 'package:shop_cart_tav_flutter/Views/Client/client_home_screen.dart';
import 'package:shop_cart_tav_flutter/Views/Client/favorite_Screen.dart';
import 'package:shop_cart_tav_flutter/Views/User/login_screen.dart';
import 'package:shop_cart_tav_flutter/Views/Widgets/shopping_cart_screen.dart';

class AppBarWidget extends StatelessWidget {

  AppBarController _appBarController()=>Get.find<AppBarController>();

  ProductsController _productsController()=> Get.find<ProductsController>();

  FavoriteController _favoriteController()=>Get.find<FavoriteController>();

  TagsController _tagsController()=>Get.find<TagsController>();

  ShoppingCartController _shoppingCartController()=>Get.find<ShoppingCartController>();

  UserController _userController()=>Get.find<UserController>();

  final TextEditingController textEditingController1 = TextEditingController();

  final TextEditingController textEditingController2 = TextEditingController();
  List pages=[];


  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    pages=[
      {
        "name":_userController().loggedInUser.mode=='admin'? "Admin Home":"Client Home",
        "widget":_userController().loggedInUser.mode=='admin'?AdminHomeScreen():HomeScreen(),
        "icon":_userController().loggedInUser.mode=='admin'? Icons.home_work_outlined:Icons.home_outlined
      },
      {
        "name":_userController().loggedInUser.mode=='admin'?"Tags":"Favorite",
        "widget":_userController().loggedInUser.mode=='admin'? TagsScreen():FavoriteScreen(),
        "icon":_userController().loggedInUser.mode=='admin'? Icons.local_offer_outlined:Icons.favorite_border_outlined
      }

    ];

    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(context),
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView(
        controller: _appBarController().pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ...pages
              .asMap()
              .map((key, value) => MapEntry(key, value["widget"] as Widget))
              .values
              .toList()
        ],
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: Center(
        child: Obx(
          () => ListView(
            children: [
              drawerHeader(),
              ...pages
                  .asMap()
                  .map((key, value) => MapEntry(
                      key,
                      Center(
                        child: drawerItems(context, key, value),
                      )))
                  .values
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Container drawerItems(
      BuildContext context, int key, Map<String, dynamic> value) {
    return Container(
      width: MediaQuery.of(context).size.width * .73,
      decoration: BoxDecoration(
        color: _appBarController().currentIndex.value == key
            ? Colors.grey[200]
            : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(value["icon"],
            color: _appBarController().currentIndex.value == key
                ? Theme.of(context).accentColor
                : Colors.black),
        title: Text(
          value["name"] as String,
          style: TextStyle(
              color: _appBarController().currentIndex.value == key
                  ? Theme.of(context).accentColor
                  : Colors.black),
        ),
        trailing: _appBarController().currentIndex.value == key
            ? Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).accentColor,
              )
            : null,
        onTap: () {
          _appBarController().getTo(key);
        },
      ),
    );
  }

  DrawerHeader drawerHeader() {
    return DrawerHeader(
      padding: EdgeInsets.all(1),
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon:Icon(Icons.logout ,color: Colors.red,), onPressed: ()async{
              _initializeLogin();
              final box = GetStorage();
              box.remove("user");
              await  Get.off(LoginScreen());

            },
            ),
            IconButton(icon:Icon(Icons.edit_outlined),onPressed: (){},)
          ],
        ),
     Container(
              width: 90,
              height: 90,
              child: ClipOval(
                child: Image.file(
                  File(_userController()
                      .loggedInUser.image),
                  fit: BoxFit.cover,
                ),
              )),

        Padding(
          padding: const EdgeInsets.only(top:5.0),
          child: Text(_userController().loggedInUser.username),
        )
      ],
    ));
  }

  AppBar _appBar() {
    return AppBar(
      title: Obx(() => Text(_appBarController().currentIndex.value == 0
          ? pages[_appBarController().currentIndex.value]["name"]
          : pages[_appBarController().currentIndex.value]["name"])),
      actions: [actionAppbar()],
      bottom: bottomAppBar(),
    );
  }

  PreferredSize bottomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userController().loggedInUser.mode == "admin"?
            Obx(() => _appBarController().currentIndex.value == 0
                ? SearchBar(
              textEditingController$: textEditingController1,
              onChange$: (text) {
                text = text.toLowerCase();
                _productsController().searchProduct(text);
              },
            ):
            SearchBar(
              textEditingController$: textEditingController2,
              onChange$: (text) {
                text = text.toLowerCase();
                _tagsController().searchTag(text);
              },
            )):
            Obx(() => _appBarController().currentIndex.value == 0
                ? SearchBar(
                    textEditingController$: textEditingController1,
                    onChange$: (text) {
                      text = text.toLowerCase();
                      _productsController().searchProduct(text);
                    },
                  ):
            SearchBar(
                    textEditingController$: textEditingController2,
                    onChange$: (text) {
                      text = text.toLowerCase();
                      _favoriteController().searchFavorite(text);
                    },
                  ))
            // Obx(()=>_appBarController(.currentIndex.value == 0 ? IconButton(icon: Icon(Icons.filter_list , color: Colors.white,size: 25,),):Container()),
            // IconButton(icon: Icon(Icons.filter_list , color: Colors.white,size: 25,),),
            // Text('Filter', style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }

  Container actionAppbar() {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          _userController().loggedInUser.mode == "client"?   IconButton(
              icon: Icon(
                Icons.remove,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {

                _productsController().productList.sort((a,b){
                  return a.price.compareTo(b.price);
                });
              }):Container(),
          _userController().loggedInUser.mode == "client"?  GetBuilder<ShoppingCartController>(
              init: ShoppingCartController(shoppingCartRepository: ShoppingCartRepository()),
              initState: (_) => _shoppingCartController().getShoppingCart(),
              builder: (_) {
                return Stack(
                  children: [

                  IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // setState(() {
                          //
                          // });
                          Get.to(ShoppingCartScreen());
                        }),
                    _shoppingCartController().cartList.length == 0
                        ? Container()
                        : Container(
                            child: Center(
                                child: Text(
                                    '${_shoppingCartController().cartList.length}')),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                    ),
                  ],
                );
              }):Container(),
        ],
      ),
    );
  }

  void _initializeLogin() {
    _userController().usernameController.text = '';
    _userController().passwordController.text ='';
  }
}
