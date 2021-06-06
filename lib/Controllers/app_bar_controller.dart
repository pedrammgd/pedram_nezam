import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Models/user.dart';

class AppBarController extends GetxController{

  RxBool result = false.obs;
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  void getTo(int index){
    currentIndex.value = index;
    pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.linear);
    Get.back();
  }
}