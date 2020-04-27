// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveAdapter extends TypeAdapter<UserHive> {
  @override
  final typeId = 2;

  @override
  UserHive read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHive(
      id: fields[0] as int,
      name: fields[1] as String,
      username: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      website: fields[5] as String,
      company: fields[6] as CompanyHive,
    );
  }

  @override
  void write(BinaryWriter writer, UserHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.website)
      ..writeByte(6)
      ..write(obj.company);
  }
}
