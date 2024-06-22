import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../data/model/task.dart';
import '../../main.dart';
import '../../screens/home/widgets/view_dropdown.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeLoadTasks>(_onLoadTasks);
    on<HomeDeleteTask>(_onDeleteTask);
    on<HomeUpdateTask>(_onUpdateTask);
    on<HomeChangeFilter>(_onChangeFilter);
    on<HomeCompleteTask>(_onCompleteTask);
    on<HomeUndoComplete>(_onUndoComplete);
    on<HomeUndoDelete>(_onUndoDelete);
    on<HomeAddTask>(_onAddTask);
    //on<HomeReloadTask>(_onLoadTasks as EventHandler<HomeReloadTask, HomeState>);
  }
  Future<FutureOr<void>> _onLoadTasks(HomeLoadTasks event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading));
    try {
      final Box<Task> taskBox;
      if (Hive.isBoxOpen('tasks')) {
        taskBox = Hive.box<Task>('tasks');
      } else {
        taskBox = await Hive.openBox<Task>('tasks');
      }
      final tasks = taskBox.values.toList();
      emit(state.copyWith(tasks: tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }
  FutureOr<void> _onDeleteTask(HomeDeleteTask event, Emitter<HomeState> emit) async {
    //emit(state.copyWith(status: TaskStatus.loading,lastDeteledTask: null));
    final task = event.task;
    await task.delete();
    final updatedTasks = Hive.box<Task>('tasks').values.toList();
    emit(state.copyWith(
      tasks: updatedTasks,
      lastDeteledTask: task,
    ));
  }
  FutureOr<void> _onUpdateTask(HomeUpdateTask event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading));
    final task = event.task;
    await task.save();
    final tasks = Hive.box<Task>('tasks').values.toList();
    emit(state.copyWith(tasks: tasks));
  }
  FutureOr<void> _onChangeFilter(HomeChangeFilter event, Emitter<HomeState> emit) async {
    emit(state.copyWith(filter: event.filter));
  }
  FutureOr<void> _onCompleteTask(HomeCompleteTask event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading)); // Set status to loading before completing the task
    final task = event.task;
    try {
      await task.complete();
      //await task.save();
      final tasks = Hive.box<Task>('tasks').values.toList();
      emit(state.copyWith(tasks: tasks, status: TaskStatus.success)); // Set status to success after updating the task
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error)); // Set status to error if an exception occurs
    }
  }
  FutureOr<void> _onUndoComplete(HomeUndoComplete event, Emitter<HomeState> emit) async {
    emit (state.copyWith(status: TaskStatus.loading));
    final task = event.task;
    try {
      await task.undoCompleted();
      //await task.save();
      final tasks = Hive.box<Task>('tasks').values.toList();
      emit(state.copyWith(tasks: tasks, status: TaskStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TaskStatus.error));
    }
  }
  FutureOr<void> _onUndoDelete(HomeUndoDelete event, Emitter<HomeState> emit) async {
    final task = event.task;
    await task.undoDeleted();
    emit(state.copyWith(
      tasks: [...state.tasks, task],
      lastDeteledTask: null,
    ));
  }
  FutureOr<void> _onAddTask(HomeAddTask event, Emitter<HomeState> emit) async {
    navigatorKey.currentState!.pushNamed('/add_task');
  }
}



