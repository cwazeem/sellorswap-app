class Store {
  int id;
  int userId;
  String name;
  String logo;
  StoreLocation location;
  String address;
  int idCardNo;
  int idCard;
  String idCardVerifiedAt;
  int status;
  int topSeller;
  String createdAt;
  String updatedAt;

  Store(
      {this.id,
      this.userId,
      this.name,
      this.logo,
      this.location,
      this.address,
      this.idCardNo,
      this.idCard,
      this.idCardVerifiedAt,
      this.status,
      this.topSeller,
      this.createdAt,
      this.updatedAt});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    logo = json['logo'];
    location = json['location'] != null
        ? new StoreLocation.fromJson(json['location'])
        : null;
    address = json['address'];
    idCardNo = json['id_card_no'];
    idCard = json['id_card'];
    idCardVerifiedAt = json['id_card_verified_at'];
    status = json['status'];
    topSeller = json['top_seller'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['logo'] = this.logo;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['address'] = this.address;
    data['id_card_no'] = this.idCardNo;
    data['id_card'] = this.idCard;
    data['id_card_verified_at'] = this.idCardVerifiedAt;
    data['status'] = this.status;
    data['top_seller'] = this.topSeller;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class StoreLocation {
  String type;
  List<double> coordinates;

  StoreLocation({this.type, this.coordinates});

  StoreLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
