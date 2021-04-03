import 'package:hive/hive.dart';

part 'geo_model.g.dart';

@HiveType(typeId: 3)
class Geo extends HiveObject{

  @HiveField(0)
  String lat;
  @HiveField(1)
  String lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}