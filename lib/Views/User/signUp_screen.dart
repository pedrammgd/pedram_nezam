import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Other/Widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  UserController _userController()=>Get.find<UserController>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Material(
                        color: Colors.green[300], // Button color
                        child: InkWell(
                          splashColor: Colors.white, // Splash color
                          onTap: () {Get.back();},
                          child: SizedBox(width: 46, height: 46, child: Icon(Icons.arrow_back)),
                        ),
                      ),
                    ),
                  ),

                  ],),

                Obx(() => _userController().selectImagePath.value == ''
                      ? Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          _userController().getUserImage(ImageSource.camera);
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          child: CircleAvatar(
                            child: Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                )),
                            backgroundColor: Colors.green,
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
                            _userController()
                                .getUserImage(ImageSource.gallery);
                          },
                        ),
                      )
                    ],
                  )
                      : Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          _userController().getUserImage(ImageSource.camera);
                        },
                        child: Container(
                            width: 150,
                            height: 150,
                            child: ClipOval(
                              child: Image.file(
                                File(_userController()
                                    .selectImagePath.value),
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
                            _userController()
                                .getUserImage(ImageSource.gallery);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomTextField(
                    prefixIcon$: Icon(Icons.person_outlined),
                    validator$: (value){
                      if(value ==null || value.isEmpty){
                        return 'username is Empty';
                      }
                      return null;
                    },
                    hintText$: 'Username',
                    controller$: _userController().usernameController,),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomTextField(
                    prefixIcon$: Icon(Icons.person),
                    validator$: (value){
                      if(value ==null || value.isEmpty){
                        return 'lastName is Empty';
                      }
                      return null;
                    },
                    hintText$: 'LastName',
                    controller$: _userController().lastNameController,),
                ),
                Obx(()=>
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomTextField(
                      prefixIcon$: Icon(Icons.lock_outline),
                      obscureText$: _userController().observ.value,
                      suffixIcon$: IconButton(icon: Icon(_userController().observ.value ?Icons.visibility_off:Icons.visibility),onPressed: (){
                        _userController().observ.value =!_userController().observ.value;
                      },),
                      validator$: (value){
                        if(value ==null || value.isEmpty){
                          return 'password is Empty';
                        }
                        return null;
                      },
                      hintText$: 'Password',
                      controller$: _userController().passwordController,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomTextField(
                    maxLength$: 11,
                    keyboardType$: TextInputType.number,
                    prefixIcon$: Icon(Icons.phone_android),
                    validator$: (value){
                      if(value ==null || value.isEmpty){
                        return 'mobile is Empty';
                      }
                      return null;
                    },
                    hintText$: 'Mobile',
                    controller$: _userController().mobileController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CustomTextField(
                    contentPadding$: EdgeInsets.symmetric(vertical: 30),
                    prefixIcon$: Icon(Icons.map_outlined),
                    validator$: (value){
                      if(value ==null || value.isEmpty){
                        return 'Address is Empty';
                      }
                      return null;
                    },
                    hintText$: 'Address',
                    controller$: _userController().addressController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.green[300], // Button color
                      child: InkWell(
                        splashColor: Colors.green, // Splash color
                        onTap: () {
                          if(_formKey.currentState.validate()) {
                            _userController().addSignUpUser();
                            Get.back();
                            Get.snackbar('SuccessRegister', ' username: ${_userController().usernameController.text}   password : ${_userController().passwordController.text}' ,duration:Duration(seconds: 6) );
                          }
                          },
                        child: SizedBox(width: 60, height: 60, child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
