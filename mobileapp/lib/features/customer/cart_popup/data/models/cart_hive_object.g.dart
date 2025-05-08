// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartAdapter extends TypeAdapter<Cart> {
  @override
  final int typeId = 3;

  @override
  Cart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cart(
      id: fields[0] as String,
      delPrice: fields[1] as double,
      name: fields[2] as String,
      pic: fields[3] as String,
      prod: (fields[4] as List).cast<Product>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cart obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.delPrice)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pic)
      ..writeByte(4)
      ..write(obj.prod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
