import 'package:flutter_local_db/src/data/hive/address_hive.dart';
import 'package:flutter_local_db/src/data/hive/company_hive.dart';
import 'package:hive/hive.dart';
part 'user_hive.g.dart';

@HiveType(typeId: 2)
class UserHive extends HiveObject {

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String username;
  @HiveField(3)
  String email;
  @HiveField(4)
  AddressHive address;
  @HiveField(5)
  String phone;
  @HiveField(6)
  String website;
  @HiveField(7)
  CompanyHive company;

  UserHive({this.id, this.name, this.username, this.email, this.address, this.phone, this.website, this.company});

}