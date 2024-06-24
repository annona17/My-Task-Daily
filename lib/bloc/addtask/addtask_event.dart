part of 'addtask_bloc.dart';

sealed class AddTaskEvent extends Equatable{
  const AddTaskEvent();
}

final class AddTaskChangeTittle extends AddTaskEvent {
  final String title;
  const AddTaskChangeTittle(this.title);
  @override
  List<Object> get props => [title];
}

final class AddTaskChangeDescription extends AddTaskEvent {
  final String description;
  const AddTaskChangeDescription(this.description);
  @override
  List<Object> get props => [description];
}

final class AddTaskChangeDate extends AddTaskEvent {
  final DateTime date;
  const AddTaskChangeDate(this.date);
  @override
  List<Object> get props => [date];
}
final class AddTaskChangeStartTime extends AddTaskEvent {
  final TimeOfDay startTime;
  const AddTaskChangeStartTime(this.startTime);
  @override
  List<Object> get props => [startTime];
}

final class AddTaskChangeEndTime extends AddTaskEvent {
  final TimeOfDay endTime;
  const AddTaskChangeEndTime(this.endTime);
  @override
  List<Object> get props => [endTime];
}
final class AddTaskChangePriority extends AddTaskEvent {
  final PriorityType priority;
  const AddTaskChangePriority(this.priority);
  @override
  List<Object> get props => [priority];
}
final class AddTaskChangeColor extends AddTaskEvent {
  final Color color;
  const AddTaskChangeColor(this.color);
  @override
  List<Object> get props => [color];
}
class AddTaskCreate extends AddTaskEvent {
  final BuildContext context;
  const AddTaskCreate(this.context);
  @override
  List<Object> get props => [context];
}