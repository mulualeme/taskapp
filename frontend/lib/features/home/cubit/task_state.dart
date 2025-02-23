part of 'task_cubit.dart';

sealed class TaskState {
  const TaskState();
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class AddNewTaskSuccess extends TaskState {
  final TaskModel task;

  AddNewTaskSuccess(this.task);
}

final class TaskError extends TaskState {
  final String error;

  TaskError(this.error);
}

final class GetTasksSuccess extends TaskState {
  final List<TaskModel> tasks;

  GetTasksSuccess(this.tasks);
}
