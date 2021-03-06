// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsAdapter extends TypeAdapter<Accounts> {
  @override
  final int typeId = 0;

  @override
  Accounts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Accounts(
      name: fields[0] as String?,
      roll: fields[1] as int?,
      imagePath: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Accounts obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.roll)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
