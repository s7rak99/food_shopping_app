class InvoiceModel {
  int? quantity;
  double? total;
  String? dateTime;

  InvoiceModel({
    this.quantity,
    this.total,
    this.dateTime,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    total = json['total'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'total': total,
      'dateTime': dateTime,
    };
  }
}
