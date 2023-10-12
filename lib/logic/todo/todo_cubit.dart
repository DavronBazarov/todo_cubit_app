import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(
          TodoInitial(
            [
              Todo(
                id: UniqueKey().toString(),
                title: "Go home",
                isDone: true,
              ),
              Todo(
                id: UniqueKey().toString(),
                title: "Go swimming",
                isDone: false,
              ),
              Todo(
                id: UniqueKey().toString(),
                title: "Go shopping",
                isDone: false,
              ),
            ],
          ),
        );

  void addTodo(String title) {
    try {
      final todo = Todo(id: UniqueKey().toString(), title: title);
      final todos = [...state.todos!, todo];
      emit(TodoAdded());
      emit(TodoState(todos: todos));
    } catch (_) {
      emit(TodoError("Error occured!"));
    }
  }

  void editTodo(String id, String title) {
    try {
      final todos = state.todos!.map((e) {
        if (e.id == id) {
          return Todo(id: id, title: title, isDone: e.isDone);
        }
        return e;
      }).toList();
      emit(TodoEdited());
      emit(TodoState(todos: todos));
    } catch (_) {
      emit(TodoError("Error occured!"));
    }
  }

  void toggleTodo(String id) {
    final todos = state.todos!.map((e) {
      if(e.id == id){
        return Todo(id: e.id, title: e.title, isDone: !e.isDone);
      }
      return e;
    }).toList();
    emit(TodoToggled());
    emit(TodoState(todos: todos));
  }

  void deleteTodo(String id) {
    final todos = state.todos;
    todos!.removeWhere((element) => element.id == id);
    emit(DeletedTodo());
    emit(TodoState(todos: todos));
  }
}
