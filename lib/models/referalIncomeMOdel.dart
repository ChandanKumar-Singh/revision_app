class ReferralIncomeModel {
  int? id;
  int? userId;
  int? directId;
  String? fromDate;
  String? toDate;
  String? totalSale;
  String? totalRecieved;
  int? level;
  int? percentage;
  String? referralIncome;
  String? createdAt;
  String? updatedAt;
  DirectIncomes? directIncomes;

  ReferralIncomeModel(
      {this.id,
        this.userId,
        this.directId,
        this.fromDate,
        this.toDate,
        this.totalSale,
        this.totalRecieved,
        this.level,
        this.percentage,
        this.referralIncome,
        this.createdAt,
        this.updatedAt,
        this.directIncomes});

  ReferralIncomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    directId = json['direct_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalSale = json['total_sale'];
    totalRecieved = json['total_recieved'];
    level = json['level'];
    percentage = json['percentage'];
    referralIncome = json['referral_income'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    directIncomes = json['direct_incomes'] != null
        ? DirectIncomes.fromJson(json['direct_incomes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['direct_id'] = directId;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['total_sale'] = totalSale;
    data['total_recieved'] = totalRecieved;
    data['level'] = level;
    data['percentage'] = percentage;
    data['referral_income'] = referralIncome;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (directIncomes != null) {
      data['direct_incomes'] = directIncomes!.toJson();
    }
    return data;
  }
}

class DirectIncomes {
  int? id;
  int? userId;
  String? fromDate;
  String? toDate;
  String? totalDirect;
  String? totalSale;
  String? totalReceived;
  int? level;
  int? percentage;
  String? directIncome;
  int? isProcess;
  String? createdAt;
  String? updatedAt;
  User? user;

  DirectIncomes(
      {this.id,
        this.userId,
        this.fromDate,
        this.toDate,
        this.totalDirect,
        this.totalSale,
        this.totalReceived,
        this.level,
        this.percentage,
        this.directIncome,
        this.isProcess,
        this.createdAt,
        this.updatedAt,
        this.user});

  DirectIncomes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalDirect = json['total_direct'];
    totalSale = json['total_sale'];
    totalReceived = json['total_received'];
    level = json['level'];
    percentage = json['percentage'];
    directIncome = json['direct_income'];
    isProcess = json['is_process'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['total_direct'] = totalDirect;
    data['total_sale'] = totalSale;
    data['total_received'] = totalReceived;
    data['level'] = level;
    data['percentage'] = percentage;
    data['direct_income'] = directIncome;
    data['is_process'] = isProcess;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class DirectIncomeModel {
  int? id;
  int? userId;
  String? fromDate;
  String? toDate;
  String? totalDirect;
  String? totalSale;
  String? totalReceived;
  int? level;
  int? percentage;
  String? directIncome;
  int? isProcess;
  String? createdAt;
  String? updatedAt;

  DirectIncomeModel(
      {this.id,
        this.userId,
        this.fromDate,
        this.toDate,
        this.totalDirect,
        this.totalSale,
        this.totalReceived,
        this.level,
        this.percentage,
        this.directIncome,
        this.isProcess,
        this.createdAt,
        this.updatedAt});

  DirectIncomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalDirect = json['total_direct'];
    totalSale = json['total_sale'];
    totalReceived = json['total_received'];
    level = json['level'];
    percentage = json['percentage'];
    directIncome = json['direct_income'];
    isProcess = json['is_process'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['total_direct'] = this.totalDirect;
    data['total_sale'] = this.totalSale;
    data['total_received'] = this.totalReceived;
    data['level'] = this.level;
    data['percentage'] = this.percentage;
    data['direct_income'] = this.directIncome;
    data['is_process'] = this.isProcess;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}