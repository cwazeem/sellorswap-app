import 'package:sell_or_swap/models/store.dart';

class User {
  int id;
  String name;
  String email;
  String mobile;
  String emailVerifiedAt;
  String avatar;
  String fcmToken;
  int countryId;
  String createdAt;
  String updatedAt;
  String role;
  Country country;
  Store store;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.emailVerifiedAt,
      this.avatar,
      this.fcmToken,
      this.countryId,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.country,
      this.store});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    fcmToken = json['fcm_token'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['avatar'] = this.avatar;
    data['fcm_token'] = this.fcmToken;
    data['country_id'] = this.countryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    // if (this.store != null) {
    //   data['store'] = this.store.toJson();
    // }
    return data;
  }
}

class Country {
  int id;
  String name;
  String isoAlpha2;
  String isoAlpha3;
  int isoNumeric;
  String callingCode;
  String currencyCode;
  String currencyName;
  String currencySymbol;
  String flag;
  int active;

  Country(
      {this.id,
      this.name,
      this.isoAlpha2,
      this.isoAlpha3,
      this.isoNumeric,
      this.callingCode,
      this.currencyCode,
      this.currencyName,
      this.currencySymbol,
      this.flag,
      this.active});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isoAlpha2 = json['iso_alpha2'];
    isoAlpha3 = json['iso_alpha3'];
    isoNumeric = json['iso_numeric'];
    callingCode = json['calling_code'];
    currencyCode = json['currency_code'];
    currencyName = json['currency_name'];
    currencySymbol = json['currency_symbol'];
    flag = json['flag'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['iso_alpha2'] = this.isoAlpha2;
    data['iso_alpha3'] = this.isoAlpha3;
    data['iso_numeric'] = this.isoNumeric;
    data['calling_code'] = this.callingCode;
    data['currency_code'] = this.currencyCode;
    data['currency_name'] = this.currencyName;
    data['currency_symbol'] = this.currencySymbol;
    data['flag'] = this.flag;
    data['active'] = this.active;
    return data;
  }
}
