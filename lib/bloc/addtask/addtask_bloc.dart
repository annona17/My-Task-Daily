import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/model/task.dart';

import '../../main.dart';
import '../../screens/add_task/widget/priority_choice.dart';
import '../home/home_bloc.dart';

part 'addtask_event.dart';
part 'addtask_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  late Task _task;
  AddTaskBloc({Task}) : super(AddTaskState.initial()) {
    on<AddTaskChangeTittle>(_onChangeTitle);
    on<AddTaskChangeDescription>(_onChangeDescription);
    on<AddTaskChangeDate>(_onChangeDate);
    on<AddTaskChangeStartTime>(_onChangeStartTime);
    on<AddTaskChangeEndTime>(_onChangeEndTime);
    on<AddTaskChangePriority>(_onChangePriority);
    on<AddTaskChangeColor>(_onChangeColor);
    on<AddTaskCreate>(_onCreateTask);
  }
  FutureOr<void> _onChangeTitle(
      AddTaskChangeTittle event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(tittle: event.tittle));
  }

  FutureOr<void> _onChangeDescription(
      AddTaskChangeDescription event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(description: event.description));
  }

  FutureOr<void> _onChangeDate(
      AddTaskChangeDate event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(date: event.date));
  }

  FutureOr<void> _onChangeStartTime(
      AddTaskChangeStartTime event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(startTime: event.startTime));
  }

  FutureOr<void> _onChangeEndTime(
      AddTaskChangeEndTime event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(endTime: event.endTime));
  }

  FutureOr<void> _onChangePriority(
      AddTaskChangePriority event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(priority: event.priority.toString()));
  }

  FutureOr<void> _onChangeColor(
      AddTaskChangeColor event, Emitter<AddTaskState> emit) {
    emit(state.copyWith(color: event.color));
  }
  FutureOr<void> _onCreateTask(
      AddTaskCreate event, Emitter<AddTaskState> emit) {
    String startTimeString = '${state.startTime.hour.toString().padLeft(2, '0')}:${state.startTime.minute.toString().padLeft(2, '0')}';
    String endTimeString = '${state.endTime.hour.toString().padLeft(2, '0')}:${state.endTime.minute.toString().padLeft(2, '0')}';
    _task = Task(
      title: state.title,
      description: state.description,
      date: state.date,
      startTime: startTimeString,
      endTime: endTimeString,
      priority: state.priority,
      color: state.color.value,
    );
    saveTask();
    navigatorKey.currentState!.pop();

    final homeBloc = BlocProvider.of<HomeBloc>(event.context);
    homeBloc.add(const HomeLoadTasks());

    emit(state.copyWith(task: _task, isCompleted: true));
  }

  // luu vao hive
  void saveTask() {
    Hive.box<Task>('tasks').put(_task.id, _task);
    print('Task added successfully!');
  }
}

