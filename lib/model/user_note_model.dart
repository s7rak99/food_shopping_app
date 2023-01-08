class UserNoteModel {
  String? note;
  String? uId;
  String? productId;
  String? name;


  UserNoteModel({
    this.note,
    this.uId,
    this.productId,
    this.name,


  });

  UserNoteModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    uId = json['uId'];
    productId = json['productId'];
    name = json['name'];

  }

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'uId': uId,
      'productId': productId,
      'name': name,

    };
  }
}

