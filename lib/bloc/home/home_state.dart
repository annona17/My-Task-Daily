part of 'home_bloc.dart';

enum TaskStatus { initial, loading, success, error }

final class HomeState extends Equatable {
  final List<Task> tasks;
  final TaskStatus status;
  final ViewFilter filter;
  final Task? lastDeteledTask;


  const HomeState({
    required this.tasks,
    required this.status,
    required this.filter,
    this.lastDeteledTask,
  });

  factory HomeState.initial() {
    return const HomeState(
      tasks: [],
      status: TaskStatus.initial,
      filter: ViewFilter.All,
    );
  }


  @override
  List<Object?> get props => [tasks, status, filter, lastDeteledTask];
  HomeState copyWith({
    List<Task>? tasks,
    TaskStatus? status,
    ViewFilter? filter,
    Task? lastDeteledTask,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      lastDeteledTask: lastDeteledTask ?? this.lastDeteledTask,
    );
  }
}

