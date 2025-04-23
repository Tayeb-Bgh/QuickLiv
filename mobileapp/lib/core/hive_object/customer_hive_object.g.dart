// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerHiveObjectAdapter extends TypeAdapter<CustomerHiveObject> {
  @override
  final int typeId = 0;

  @override
  CustomerHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerHiveObject(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      phone: fields[3] as String,
      registerDate: fields[4] as DateTime,
      points: fields[5] as int,
      isSubmittedDeliverer: fields[6] as bool,
      isSubmittedPartner: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerHiveObject obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.registerDate)
      ..writeByte(5)
      ..write(obj.points)
      ..writeByte(6)
      ..write(obj.isSubmittedDeliverer)
      ..writeByte(7)
      ..write(obj.isSubmittedPartner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
