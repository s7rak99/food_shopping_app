class AdminMessageModel {
  String? message;
  String? uId;
  String? productName;



  AdminMessageModel({
    this.message,
    this.uId,
    this.productName,


  });

  AdminMessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    uId = json['uId'];
    productName = json['productName'];

  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'uId': uId,
      'productName': productName,
    };
  }
}

