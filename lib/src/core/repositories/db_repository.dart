import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class DbRepository<T> {
  final CollectionSchema<T> collectionSchema;

  Future<Isar>? _openFuture;

  DbRepository(this.collectionSchema);

  /// Awaitable, lazily-opened handle to the database.
  ///
  /// The [Isar] instance is opened on first access and the resulting future
  /// is shared by all callers, so no operation can run before the DB is open.
  /// If opening fails, the error is propagated to every caller awaiting this
  /// future and the cached future is reset so a later access can retry.
  Future<Isar> get isarAsync {
    final future = _openFuture ??= _openIsar();
    return future.catchError((e, st) {
      if (identical(_openFuture, future)) _openFuture = null;
      Error.throwWithStackTrace(e, st);
    });
  }

  Future<Isar> _openIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    debugPrint("DbRepository # path ${dir.path}");
    return Isar.open([collectionSchema], directory: dir.path);
  }
}
