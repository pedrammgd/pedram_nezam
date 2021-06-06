class UserMore {
  UserMore({
   this.mobile,
    this.address
  });


  int mobile;
  String address;



  factory UserMore.fromJson(Map<String, dynamic> json) => UserMore(
     mobile: json["mobile"],
    address: json["address"]
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "address": address,
  };
}