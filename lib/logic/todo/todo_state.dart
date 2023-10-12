part of 'todo_cubit.dart';

@immutable
class TodoState {
  final List<Todo>? todos;

  const TodoState({this.todos});
}

class TodoInitial extends TodoState {
  final List<Todo> todos;

  const TodoInitial(this.todos) : super();
}

class TodoAdded extends TodoState {}

class TodoEdited extends TodoState {}

class TodoToggled extends TodoState {}

class DeletedTodo extends TodoState {}

class TodoError extends TodoState {
  String message;
  TodoError(this.message) : super();
}
