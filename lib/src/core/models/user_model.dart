import 'address_model.dart';
import 'company_model.dart';

class User {

  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  User(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone,
        this.website,
        this.company});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }

  static List<User> buildListFromJson(List<dynamic> json) {
    return json.map((dynamic x) => User.fromJson(x)).toList();
  }

}