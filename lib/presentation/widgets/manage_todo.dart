import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_app/logic/todo/todo_cubit.dart';

import '../../data/models/todo.dart';

class ManageTodo extends StatelessWidget {
  Todo? todo;

  ManageTodo({
    super.key,
    this.todo,
  });

  final _formKey = GlobalKey<FormState>();
  String _title = '';

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (todo == null) {
        // BlocProvider.of<TodoCubit>(context).addTodo(_title);
        context.read<TodoCubit>().addTodo(_title);
      } else {
        // BlocProvider.of<TodoCubit>(context)
        //     .editTodo(Todo(id: todo!.id, title: _title, isDone: todo!.isDone));
        context
            .read<TodoCubit>()
            .editTodo(todo!.id, _title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoAdded || state is TodoEdited) {
          Navigator.of(context).pop();
        } else if (state is TodoError) {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text("Error!!!"),
                  content: Text(state.message),
                );
              });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: todo == null ? '' : todo!.title,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter title!";
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("CANCEL"),
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text(todo == null ? "ADD" : "EDIT"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
