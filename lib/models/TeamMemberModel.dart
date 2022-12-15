import 'package:revision/models/receivedEmiModel.dart';

class TeamMember {
  int? id;
  String? username;
  String? sponsorId;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? status;
  int? designationId;
  String? address;
  int? projectId;
  String? plotNo;
  String? plotArea;
  String? plotRate;
  String? plotDiscount;
  String? plotTotalPrice;
  String? emiTerm;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  List<ReceivedEmi>? emiReceived;

  TeamMember({
    this.id,
    this.username,
    this.sponsorId,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.status,
    this.designationId,
    this.address,
    this.projectId,
    this.plotNo,
    this.plotArea,
    this.plotRate,
    this.plotDiscount,
    this.plotTotalPrice,
    this.emiTerm,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.emiReceived,
  });

  TeamMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    sponsorId = json['sponsor_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    status = json['status'];
    designationId = json['designation_id'];
    address = json['address'];
    projectId = json['project_id'];
    plotNo = json['plot_no'];
    plotArea = json['plot_area'];
    plotRate = json['plot_rate'];
    plotDiscount = json['plot_discount'];
    plotTotalPrice = json['plot_total_price'];
    emiTerm = json['emi_term'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['fullName'];
    emiReceived =
        List.from(json['emi_receiveds'].map((e) => ReceivedEmi.fromJson(e)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['sponsor_id'] = sponsorId;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['status'] = status;
    data['designation_id'] = designationId;
    data['address'] = address;
    data['project_id'] = projectId;
    data['plot_no'] = plotNo;
    data['plot_area'] = plotArea;
    data['plot_rate'] = plotRate;
    data['plot_discount'] = plotDiscount;
    data['plot_total_price'] = plotTotalPrice;
    data['emi_term'] = emiTerm;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fullName'] = fullName;
    return data;
  }
}
