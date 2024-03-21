import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/db_repository.dart';

class DbUserRepository extends DbRepository<User> {
  DbUserRepository() : super(UserSchema);

  Future<void> saveData(List<User> data) async {
    isar?.writeTxn(() async {
      await isar?.clear();
      await isar?.users.putAll(data);
    });
  }
}
