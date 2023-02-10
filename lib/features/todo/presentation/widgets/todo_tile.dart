import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../cubit/todo_cubit.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final int id;
  final bool isDone;
  const ToDoTile({
    Key? key,
    required this.id,
    required this.isDone,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.indigo,
        value: isDone,
        onChanged: (value) {
          BlocProvider.of<TodoCubit>(context).updateTodo(id, !isDone);
        },
      ),
      onLongPress: () {
        BlocProvider.of<TodoCubit>(context).deleteToDo(id);
      },
    );
  }
}
