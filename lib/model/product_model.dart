class ProductModel {
  String? name;
  String? image;
  int? quantity;
  double? price;
  int? count ;


  ProductModel({
    this.name,
    this.image,
    this.quantity,
    this.price,
    this.count,

  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'count': count,

    };
  }

}

//https://t4.ftcdn.net/jpg/04/29/16/13/240_F_429161369_SPFahVfUe1YAU3EnQOFkOlxxUncAsrsB.jpg
