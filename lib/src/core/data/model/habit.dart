import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'habit.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int completionrate;
  @HiveField(2)
  int targetfrequency;
  @HiveField(3)
  String? habitcategory;
  @HiveField(4)
  int streak;
  Habit(
      {this.name,
      this.completionrate = 0,
      this.targetfrequency = 0,
      this.habitcategory,
      this.streak = 0
     });

      factory Habit.fromJson(Map<String,dynamic>json) =>
  _$HabitFromJson(json);

   void incrementCompletion() {
    completionrate++;
    if (completionrate == targetfrequency) {
      streak++;
    }
  }

  void resetStreak() {
    streak = 0;
  }
}
