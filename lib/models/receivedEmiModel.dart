class ReceivedEmi {
  int? id;
  int? userId;
  String? date;
  String? amount;
  String? paymentMode;
  String? comments;
  String? createdAt;
  String? updatedAt;

  ReceivedEmi(
      {this.id,
        this.userId,
        this.date,
        this.amount,
        this.paymentMode,
        this.comments,
        this.createdAt,
        this.updatedAt});

  ReceivedEmi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    date = json['date'];
    amount = json['amount'];
    paymentMode = json['payment_mode'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['date'] = date;
    data['amount'] = amount;
    data['payment_mode'] = paymentMode;
    data['comments'] = comments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}