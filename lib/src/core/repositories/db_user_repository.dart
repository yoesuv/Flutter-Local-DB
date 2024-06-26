import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/db_repository.dart';
import 'package:isar/isar.dart';

class DbUserRepository extends DbRepository<User> {
  DbUserRepository() : super(UserSchema);

  Future<void> saveData(List<User> data) async {
    await isar?.writeTxn(() async {
      await isar?.clear();
      await isar?.users.putAll(data);
    });
  }

  Future<List<User>> getUsers() async {
    final db = isar?.users;
    return await db?.where().findAll() ?? [];
  }

  Future<User?> getUser(int id) async {
    final db = isar?.users;
    return await db?.get(id);
  }

  Future<void> delete(User user) async {
    await isar?.writeTxn(() async {
      await isar?.users.delete(user.id ?? 0);
    });
  }
}
