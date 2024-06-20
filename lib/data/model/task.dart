
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part "task.g.dart";

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final int id = DateTime.now().millisecondsSinceEpoch;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String startTime;
  @HiveField(5)
  final String endTime;
  @HiveField(6)
  final String priority;
  @HiveField(7)
  final int color;
  @HiveField(8)
  String status = "Active";

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.priority,
    required this.color,
  });

  Task.from(Task other)
    : this (
      title: other.title,
      description: other.description,
      date: other.date,
      startTime: other.startTime,
      endTime: other.endTime,
      priority: other.priority,
      color: other.color,
    );

  TimeOfDay get startTimeOfDay {
    List<String> time = startTime.split(":");
    return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));
  }
  TimeOfDay get endTimeOfDay {
    List<String> time = endTime.split(":");
    return TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]));
  }
  Color get colorTask {
    return Color(color);
  }

  delete() {
    Hive.box<Task>("task").delete(this);
  }

  update() {
    Hive.box<Task>("task").putAt(Hive.box<Task>("task").keyAt(Hive.box<Task>("task").values.toList().indexWhere((element) => element == this)), this);
  }

  complete() {
    status = "Completed";
  }

  undoDeleted() {
    status = "Active";
  }

  save() {
    Hive.box<Task>("tasks").add(this);
  }

  undoCompleted() {
    status = "Active";
  }

}