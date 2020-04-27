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
  String phone;
  @HiveField(5)
  String website;
  @HiveField(6)
  CompanyHive company;

  UserHive({this.id, this.name, this.username, this.email, this.phone, this.website, this.company});

}