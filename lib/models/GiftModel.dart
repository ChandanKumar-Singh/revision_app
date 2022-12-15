class GiftCard {
  int? id;
  int? userId;
  int? directId;
  String? fromDate;
  String? toDate;
  String? totalBusiness;
  String? giftPack;
  int? status;
  Null? paidDate;
  Null? comments;
  String? createdAt;
  String? updatedAt;

  GiftCard(
      {this.id,
        this.userId,
        this.directId,
        this.fromDate,
        this.toDate,
        this.totalBusiness,
        this.giftPack,
        this.status,
        this.paidDate,
        this.comments,
        this.createdAt,
        this.updatedAt});

  GiftCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    directId = json['direct_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalBusiness = json['total_business'];
    giftPack = json['gift_pack'];
    status = json['status'];
    paidDate = json['paid_date'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['direct_id'] = directId;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['total_business'] = totalBusiness;
    data['gift_pack'] = giftPack;
    data['status'] = status;
    data['paid_date'] = paidDate;
    data['comments'] = comments;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}