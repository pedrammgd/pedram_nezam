import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Models/user.dart';
import 'package:shop_cart_tav_flutter/Views/User/login_screen.dart';
import 'package:shop_cart_tav_flutter/Views/app_bar.dart';


class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  UserController _userController()=>Get.find<UserController>();
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
    // _userController().surveyAdmin();
    // Timer(Duration(seconds: 2), () => Get.off(LoginScreen()));
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/splashImage.jpg'),),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: CircularProgressIndicator(),
             ),


          ],
        ),
      ),
    );
  }

  Future<void> getData() async{
    await Future.delayed(Duration(seconds: 4));
    if(box.read("user") != null){
      print(box.read('user'));
      _userController().loggedInUser=User.fromJson(box.read("user")) ;
      print(_userController().loggedInUser.lastName);
      Get.off(AppBarWidget());
    } else {
      _userController().surveyAdmin();
      Get.off(LoginScreen());
    }
  }


}
