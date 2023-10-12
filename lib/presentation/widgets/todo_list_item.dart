import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_app/logic/todo/todo_cubit.dart';
import '/data/models/todo.dart';

import 'manage_todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({
    super.key,
    required this.todo,
  });

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (c) => ManageTodo(
        todo: todo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null),
      ),
      leading: IconButton(
        onPressed: () => context.read<TodoCubit>().toggleTodo(todo.id),
        icon: todo.isDone
            ? const Icon(Icons.check_circle_rounded, color: Colors.green)
            : const Icon(Icons.circle_outlined),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => context.read<TodoCubit>().deleteTodo(todo.id),
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
