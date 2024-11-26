// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      name: fields[0] as String?,
      completionrate: fields[1] as int,
      targetfrequency: fields[2] as int,
      habitcategory: fields[3] as String?,
      streak: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.completionrate)
      ..writeByte(2)
      ..write(obj.targetfrequency)
      ..writeByte(3)
      ..write(obj.habitcategory)
      ..writeByte(4)
      ..write(obj.streak);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map<String, dynamic> json) => Habit(
      name: json['name'] as String?,
      completionrate: (json['completionrate'] as num?)?.toInt() ?? 0,
      targetfrequency: (json['targetfrequency'] as num?)?.toInt() ?? 0,
      habitcategory: json['habitcategory'] as String?,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'name': instance.name,
      'completionrate': instance.completionrate,
      'targetfrequency': instance.targetfrequency,
      'habitcategory': instance.habitcategory,
      'streak': instance.streak,
    };
