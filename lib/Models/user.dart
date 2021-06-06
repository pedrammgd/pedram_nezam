import 'package:shop_cart_tav_flutter/Models/user_more_information.dart';

class User {
  User({
    this.id,
    this.username,
    this.password,
    this.mode,
    this.lastName,
    this.mobile,
    this.address,
    this.image

  });

  int id;
  String username;
  String lastName;
  String password;
  String mode;
  int mobile;
  String address;
  String image;


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    mode: json["mode"],
    lastName: json["lastName"],
      mobile: json["mobile"],
      address: json["address"],
    image: json["image"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password":password,
    "mode":mode,
    "lastName":lastName,
    "mobile": mobile,
    "address": address,
    "image":image
  };
}