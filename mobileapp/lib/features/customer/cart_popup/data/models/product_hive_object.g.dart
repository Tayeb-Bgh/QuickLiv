// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 4;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String,
      pic: fields[1] as String,
      nom: fields[2] as String,
      descr: fields[3] as String,
      unitProd: fields[4] as bool,
      poidQuantity: fields[5] as int,
      prix: fields[6] as double,
    )..notice = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pic)
      ..writeByte(2)
      ..write(obj.nom)
      ..writeByte(3)
      ..write(obj.descr)
      ..writeByte(4)
      ..write(obj.unitProd)
      ..writeByte(5)
      ..write(obj.poidQuantity)
      ..writeByte(6)
      ..write(obj.prix)
      ..writeByte(7)
      ..write(obj.notice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
