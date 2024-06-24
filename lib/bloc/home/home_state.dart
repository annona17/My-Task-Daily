part of 'home_bloc.dart';

enum TaskStatus { initial, loading, success, error }

final class HomeState extends Equatable {
  final List<Task> tasks;
  final TaskStatus status;
  final ViewFilter filter;
  final Task? lastDeteledTask;
  final DateTime date;

  const HomeState({
    required this.tasks,
    required this.status,
    required this.filter,
    required this.date,
    this.lastDeteledTask,
  });

  factory HomeState.initial() {
    return HomeState(
      tasks: const [],
      status: TaskStatus.initial,
      filter: ViewFilter.all,
      date : DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [tasks, status, filter, lastDeteledTask];
  HomeState copyWith({
    List<Task>? tasks,
    TaskStatus? status,
    ViewFilter? filter,
    Task? lastDeteledTask,
    DateTime? date,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      date: date ?? this.date,
      lastDeteledTask: lastDeteledTask ?? this.lastDeteledTask,
    );
  }
}

