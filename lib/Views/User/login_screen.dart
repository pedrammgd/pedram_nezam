import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Controllers/user_controller.dart';
import 'package:shop_cart_tav_flutter/Other/Widgets/custom_text_form_field.dart';
import 'package:shop_cart_tav_flutter/Views/User/signUp_screen.dart';
import 'package:shop_cart_tav_flutter/Views/app_bar.dart';

class LoginScreen extends StatelessWidget {

  UserController _userController()=>Get.find<UserController>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),),
                Image.asset('assets/login.png'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    validator$: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username is Empty';
                      }
                      return null;
                    },
                    prefixIcon$: Icon(Icons.person_outlined),
                    hintText$: 'username',
                    controller$: _userController().usernameController,),
                ),
                Obx(() =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        validator$: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password is Empty';
                          }
                          return null;
                        },
                        prefixIcon$: Icon(Icons.lock),
                        obscureText$: _userController().observ.value,
                        suffixIcon$: IconButton(icon: Icon(_userController().observ
                            .value ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            _userController().observ.value =
                            !_userController().observ.value;
                          },),
                        hintText$: 'password',
                        controller$: _userController().passwordController,),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(

                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // _login();
                            await _userController().loginUser() ? Get.off(
                                AppBarWidget()) : Get.snackbar('User Not Found',
                                '${_userController().usernameController
                                    .text}  Not Exist');
                          }
                        }, child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('login'),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RichText(text: TextSpan(
                      text: 'Don\'t have an Account? ',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: [TextSpan

                        (style: TextStyle(color: Colors.blueAccent,
                          fontSize: 16),
                          text: 'SignUp',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(SignUpScreen());
                            })
                      ])),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
// void _login()async{
//   await _userController().loginUser() ?_userController().loggedInUser.mode=="admin"?Get.off(AdminAppBar()):Get.to(AppBarWidget()):Get.snackbar('User Not Found',
//       '${_userController().usernameController
//           .text}  Not Exist');
// }


}
