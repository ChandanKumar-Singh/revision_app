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

  TeamMember(
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
      this.createdAt,
      this.updatedAt,
      this.fullName});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['sponsor_id'] = this.sponsorId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['designation_id'] = this.designationId;
    data['address'] = this.address;
    data['project_id'] = this.projectId;
    data['plot_no'] = this.plotNo;
    data['plot_area'] = this.plotArea;
    data['plot_rate'] = this.plotRate;
    data['plot_discount'] = this.plotDiscount;
    data['plot_total_price'] = this.plotTotalPrice;
    data['emi_term'] = this.emiTerm;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['fullName'] = this.fullName;
    return data;
  }
}
