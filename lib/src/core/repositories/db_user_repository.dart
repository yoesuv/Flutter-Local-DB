import 'package:flutter_local_db/src/core/models/user_model.dart';
import 'package:flutter_local_db/src/core/repositories/db_repository.dart';
import 'package:isar_community/isar.dart';

class DbUserRepository extends DbRepository<User> {
  DbUserRepository() : super(UserSchema);

  Future<void> saveData(List<User> data) async {
    final db = await isarAsync;
    await db.writeTxn(() async {
      await db.users.clear();
      await db.users.putAll(data);
    });
  }

  Future<List<User>> getUsers() async {
    final db = await isarAsync;
    return db.users.where().findAll();
  }

  Future<User?> getUser(int id) async {
    final db = await isarAsync;
    return db.users.get(id);
  }

  Future<void> delete(User user) async {
    final db = await isarAsync;
    await db.writeTxn(() async {
      await db.users.delete(user.id ?? 0);
    });
  }
}
