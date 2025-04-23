// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerPointsHiveModelAdapter
    extends TypeAdapter<CustomerPointsHiveModel> {
  @override
  final int typeId = 0;

  @override
  CustomerPointsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerPointsHiveModel(
      points: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerPointsHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerPointsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CouponHiveModelAdapter extends TypeAdapter<CouponHiveModel> {
  @override
  final int typeId = 1;

  @override
  CouponHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CouponHiveModel(
      reductionCode: fields[0] as String,
      discountRate: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CouponHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.reductionCode)
      ..writeByte(1)
      ..write(obj.discountRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CouponHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
