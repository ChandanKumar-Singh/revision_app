class WithDrawModel {
  int? id;
  int? userId;
  String? requestedAmount;
  String? type;
  String? recivedAmount;
  String? requestedDate;
  String? receiveDate;
  String? userComments;
  String? adminComments;
  int? paymentStatus;
  String? createdAt;
  String? updatedAt;

  WithDrawModel(
      {this.id,
        this.userId,
        this.requestedAmount,
        this.type,
        this.recivedAmount,
        this.requestedDate,
        this.receiveDate,
        this.userComments,
        this.adminComments,
        this.paymentStatus,
        this.createdAt,
        this.updatedAt});

  WithDrawModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    requestedAmount = json['requested_amount'];
    type = json['type'];
    recivedAmount = json['recived_amount'];
    requestedDate = json['requested_date'];
    receiveDate = json['receive_date'];
    userComments = json['user_comments'];
    adminComments = json['admin_comments'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['requested_amount'] = requestedAmount;
    data['type'] = type;
    data['recived_amount'] = recivedAmount;
    data['requested_date'] = requestedDate;
    data['receive_date'] = receiveDate;
    data['user_comments'] = userComments;
    data['admin_comments'] = adminComments;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}