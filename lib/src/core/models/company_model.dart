import 'package:isar_community/isar.dart';

part 'company_model.g.dart';

@embedded
class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    catchPhrase = json['catchPhrase'] as String?;
    bs = json['bs'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }
}
