
part of 'addtask_bloc.dart';

class AddTaskState extends Equatable{
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String priority;
  final String status;
  final Color color;
  final bool isCompleted;

  const AddTaskState({
    required this.title,
    required this.description ,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.priority,
    required this.status,
    required this.color,
    required this.isCompleted
  });

  factory AddTaskState.initial() {
    return AddTaskState(
      title: '',
      description: '',
      date: DateTime.now(),
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      priority: 'Low',
      status: 'future',
      color: Colors.purple,
      isCompleted: false
    );
  }

  @override
  List<Object> get props => [title, description, date, startTime, endTime, priority, status, color];

  AddTaskState copyWith({
    String? tittle,
    String? description,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? priority,
    String? status,
    Color? color,
    Task? task,
    bool? isCompleted
  }) {
    return AddTaskState(
      title: tittle ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted
    );
  }
}
