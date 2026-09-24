import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_local_db/src/core/errors/repository_exception.dart';
import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/networks/network_helper.dart';

class AppRepository {
  AppRepository({NetworkHelper? networkHelper})
    : _networkHelper = networkHelper ?? NetworkHelper();

  final NetworkHelper _networkHelper;

  Future<List<User>> getUser() async {
    try {
      final response = await _networkHelper.get('users');
      final data = response.data;
      if (data is! List) {
        throw const FormatException(
          'Unexpected response payload: expected a list',
        );
      }
      return User.buildListFromJson(data);
    } on RepositoryException {
      rethrow;
    } catch (error, stackTrace) {
      // Translate infrastructure errors (DioException, FormatException,
      // TypeError from JSON mapping, ...) into a domain-level error so
      // callers never depend on implementation details, and preserve the
      // original stack trace.
      debugPrint('AppRepository.getUser failed: $error');
      Error.throwWithStackTrace(
        RepositoryException('Failed to load users', cause: error),
        stackTrace,
      );
    }
  }
}
