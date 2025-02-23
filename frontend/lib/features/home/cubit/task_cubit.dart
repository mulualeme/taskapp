import 'package:flutter/material.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';
import 'package:frontend/models/task_model.dart';
import 'package:bloc/bloc.dart';
part 'task_state.dart';

class TasksCubit extends Cubit<TaskState> {
  TasksCubit() : super(TaskInitial());

  Future<void> createNewTask({
    required String title,
    required String description,
    required Color color,
    required DateTime dueAt,
    required String token,
  }) async {
    try {
      emit(TaskLoading());
      final taskModel = await TaskRemoteRepository().createTask(
        title: title,
        description: description,
        hexColor: rgbToHex(color),
        dueAt: dueAt,
        token: token,
      );
      emit(AddNewTaskSuccess(taskModel));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> getAllTasks({
    required String token,
  }) async {
    try {
      emit(TaskLoading());
      final taskModel = await TaskRemoteRepository().getTasks(
        token: token,
      );
      emit(GetTasksSuccess(taskModel));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
