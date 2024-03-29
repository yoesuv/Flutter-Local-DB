import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class DbRepository<T> {

  final CollectionSchema<T> collectionSchema;
  Isar? isar;

  DbRepository(this.collectionSchema) {
    _initCollectionSchema();
  }

  Future<void> _initCollectionSchema() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path;
    debugPrint("DbRepository # path $path");
    isar ??= await Isar.open([collectionSchema], directory: path);
  }

}