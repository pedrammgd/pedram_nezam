import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_cart_tav_flutter/Controllers/repositories/user_repository.dart';
import 'package:shop_cart_tav_flutter/Models/user.dart';
import 'package:shop_cart_tav_flutter/Models/user_more_information.dart';

class UserController extends GetxController {
  List<User> userList = [];

  final UserRepository userRepository;

  User loggedInUser;
  RxBool observ = false.obs;
  GetStorage box = GetStorage();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  UserController({this.userRepository});

  var selectImagePath = ''.obs;

  void getUserImage(ImageSource imageSource) async {
    final pickFile = await ImagePicker().getImage(source: imageSource);
    if (pickFile != null) {
      selectImagePath.value = pickFile.path;
    } else {
      Get.snackbar('Error', 'No Image selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsers();
  }

  serializer(List data) {
    userList = [];
    for (var item in data) {
      userList.add(User.fromJson(item));
    }
    update();
  }

  void getUsers() async {
    await userRepository
        .getUser()
        .then((value) => serializer(value.data as List));
  }

  void editUsers(User editUser) async {
    await userRepository.editUser(editUser).then((value) {
      getUsers();
    });
  }

  void postUser(User adduser) async {
    await userRepository.addUser(adduser).then((value) => value.data);
    getUsers();
  }

  void removeUser(int id) async {
    await userRepository.deleteUser(id).then((value) {
      getUsers();
    });
  }

  findUser(String findUser) async {
    await userRepository
        .finUser(findUser)
        .then((value) => serializer(value.data as List));
  }

  Future<bool> loginUser() async {
    bool isLogged = false;
    await userRepository
        .finUser(
            'username=${usernameController.text}&password=${passwordController.text}')
        .then((value) =>
            isLogged = setUserInformation(value.data as List<dynamic>));


    box.writeIfNull("user", loggedInUser.toJson());

    // box.write("isAdmin", loggedInUser.mode == "admin");

    return isLogged;
  }

  bool setUserInformation(List<dynamic> data) {
    if (data.isEmpty) {
      return false;
    }
    loggedInUser = User.fromJson(data[0]);


    return true;
  }

  void surveyAdmin() async {
    await userRepository.finUser('mode=admin').then((value) async {
      List<dynamic> data = value.data as List<dynamic>;

      if (data.isEmpty) {
        await addAdmin();
      }
    });
  }

  Future<void> addAdmin() async {
    User adminUser =
        User(username: 'admin',lastName: 'mojarad', password: 'admin', id: 1, mode: 'admin',mobile: 00000000,address: 'Shiraz',image: '');
    await userRepository.addUser(adminUser);
  }

  void addSignUpUser() {
    User addUser = User(
        username: usernameController.text,
        password: passwordController.text,
        mode: 'client',
        lastName: lastNameController.text,
        address: addressController.text,
        mobile: int.parse(mobileController.text),
        image: selectImagePath.value);
    postUser(addUser);
  }
}
