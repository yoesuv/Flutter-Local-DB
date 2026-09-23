import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/networks/network_helper.dart';

class AppRepository {
  final NetworkHelper _networkHelper = NetworkHelper();

  Future<List<User>> getUser() async {
    final response = await _networkHelper.get('users');
    final data = response.data;
    if (data is! List) {
      throw const FormatException(
        'Unexpected response payload: expected a list',
      );
    }
    return User.buildListFromJson(data);
  }
}
