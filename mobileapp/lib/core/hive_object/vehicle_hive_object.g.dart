// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleHiveObjectAdapter extends TypeAdapter<VehicleHiveObject> {
  @override
  final int typeId = 1;

  @override
  VehicleHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleHiveObject(
      id: fields[0] as int,
      registerNbr: fields[1] as String,
      brand: fields[2] as String,
      model: fields[3] as String,
      color: fields[4] as String,
      year: fields[5] as DateTime,
      insuranceExpr: fields[6] as DateTime,
      type: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleHiveObject obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.registerNbr)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.model)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.insuranceExpr)
      ..writeByte(7)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
