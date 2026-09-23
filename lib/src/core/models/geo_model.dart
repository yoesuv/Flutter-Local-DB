import 'package:isar_community/isar.dart';

part 'geo_model.g.dart';

@embedded
class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toString();
    lng = json['lng']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
