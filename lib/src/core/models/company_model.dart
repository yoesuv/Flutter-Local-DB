import 'package:hive/hive.dart';
part 'company_model.g.dart';

@HiveType(typeId: 1)
class Company extends HiveObject {

  @HiveField(0, defaultValue: "")
  String? name;
  @HiveField(1, defaultValue: "")
  String? catchPhrase;
  @HiveField(2, defaultValue: "")
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }

}