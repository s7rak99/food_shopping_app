class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isAdmin;
  String? image;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isAdmin,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isAdmin = json['isAdmin'];
    image = json['image'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isAdmin': isAdmin,
      'image' : image,
    };
  }
}

