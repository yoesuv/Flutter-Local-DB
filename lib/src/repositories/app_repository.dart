import 'package:dio/dio.dart';
import 'package:flutter_local_db/src/models/user_model.dart';
import 'package:flutter_local_db/src/networks/network_helper.dart';

class AppRepository {
  
  final NetworkHelper _networkHelper = NetworkHelper();
  
  Future<List<User>> getUser() async{
    final Response<dynamic> response = await _networkHelper.get('users') as Response<dynamic>;
    return User.buildListFromJson(response.data);
  }
  
}