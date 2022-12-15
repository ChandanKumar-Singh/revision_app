class ReferralMember {
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
  String? deviceToken;
  String? createdAt;
  String? updatedAt;
  String? fullName;

  ReferralMember(
      {this.id,
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
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
        this.fullName});

  ReferralMember.fromJson(Map<String, dynamic> json) {
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
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fullName'] = fullName;
    return data;
  }
}