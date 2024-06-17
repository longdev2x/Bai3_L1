import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class TaskEntity {

  final String id;
  final String mainTask;
  final bool? isDone;
  final List<String>? additionalTasks;
  final DateTime date;
  final DateTime? reminderDate;
  final bool? repeat;
  final String? categoryId;
  final bool? isFlag;

  TaskEntity({
    String? id,
    required this.mainTask,
    this.isDone = false,
    this.additionalTasks,
    required this.date,
    this.reminderDate,
    this.isFlag = false,
    this.repeat = false,
    this.categoryId,
  }) : id = id ?? const Uuid().v4();

  TaskEntity copyWith(
          {String? mainTask,
          bool? isDone = false,
          List<String>? additionalTasks,
          DateTime? date,
          DateTime? reminderDate,
          bool? repeat = false,
          bool? isFlag = false,
          String? categoryId}) =>
      TaskEntity(
        id: id,
        mainTask: mainTask ?? this.mainTask,
        isDone: isDone ?? this.isDone,
        additionalTasks: additionalTasks ?? this.additionalTasks,
        date: date ?? this.date,
        reminderDate: reminderDate ?? this.reminderDate,
        repeat: repeat ?? this.repeat,
        isFlag: isFlag ?? this.isFlag,
        categoryId: categoryId ?? this.categoryId,
      );

  factory TaskEntity.fromJson(Map<String, dynamic> json) => TaskEntity(
        id: json['id'],
        mainTask: json['main_task'],
        isDone: json['is_done'],
        additionalTasks: List<String>.from(json['anditional_tasks']),
        date: json['date'] != null ? (json['date'] as Timestamp).toDate() : DateTime.now(),
        reminderDate: json['reminder_date'] != null ? (json['reminder_date'] as Timestamp).toDate() : null,
        repeat: json['repeat'] ?? false,
        isFlag: json['is_flag'] ?? false,
      );

  Map<String, dynamic> toJson() => {
    'id' : id,
    'main_task' : mainTask,
    'is_done' : isDone,
    'anditional_tasks' : additionalTasks,
    'date' : date,
    'reminder_date' : reminderDate,
    'repeat' : repeat,
    'is_flase' : isFlag
  };
}
