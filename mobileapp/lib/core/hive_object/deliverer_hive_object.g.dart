// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliverer_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DelivererHiveObjectAdapter extends TypeAdapter<DelivererHiveObject> {
  @override
  final int typeId = 2;

  @override
  DelivererHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DelivererHiveObject(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      phone: fields[3] as String,
      registerDate: fields[4] as DateTime,
      rating: fields[5] as double,
      deliveryNbr: fields[6] as int,
      email: fields[7] as String,
      adrs: fields[8] as String,
      status: fields[9] as bool,
      nbrOrderThisDay: fields[10] as int?,
      profitsThisDay: fields[11] as double?,
      vehicle: fields[12] as VehicleHiveObject,
    );
  }

  @override
  void write(BinaryWriter writer, DelivererHiveObject obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.deliveryNbr)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.adrs)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.nbrOrderThisDay)
      ..writeByte(11)
      ..write(obj.profitsThisDay)
      ..writeByte(12)
      ..write(obj.vehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DelivererHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
