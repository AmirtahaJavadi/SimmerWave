// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_schema.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadioSchemaAdapter extends TypeAdapter<RadioSchema> {
  @override
  final typeId = 0;

  @override
  RadioSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RadioSchema(
      id: fields[0] as String,
      name: fields[1] as String,
      streamURL: fields[2] == null ? '' : fields[2] as String,
      imageURL: fields[3] == null ? '' : fields[3] as String,
      description: fields[4] == null ? '' : fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RadioSchema obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.streamURL)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadioSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
