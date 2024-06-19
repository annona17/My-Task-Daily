part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable{
  const HomeEvent();
}

final class HomeLoadTasks extends HomeEvent {
  const HomeLoadTasks();
  @override
  List<Object> get props => [];
}

final class HomeDeleteTask extends HomeEvent {
  final Task task;
  const HomeDeleteTask(this.task);
  @override
  List<Object> get props => [task];
}

final class HomeUpdateTask extends HomeEvent {
  final Task task;
  const HomeUpdateTask(this.task);
  @override
  List<Object> get props => [task];
}

final class HomeChangeFilter extends HomeEvent {
  final ViewFilter filter;
  const HomeChangeFilter(this.filter);
  @override
  List<Object> get props => [filter];
}

final class HomeCompleteTask extends HomeEvent {
  final Task task;
  const HomeCompleteTask(this.task);
  @override
  List<Object> get props => [task];
}

final class HomeUndoDelete extends HomeEvent {
  final Task task;
  const HomeUndoDelete(this.task);
  @override
  List<Object> get props => [task];
}

final class HomeAddTask extends HomeEvent {
  const HomeAddTask();
  @override
  List<Object> get props => [];
}
final class HomeReloadTask extends HomeEvent {
  const HomeReloadTask();
  @override
  List<Object> get props => [];
}
