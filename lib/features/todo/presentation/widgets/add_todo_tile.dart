import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';

class AddToDoTile extends StatelessWidget {
  final TextEditingController controller;
  const AddToDoTile({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListTile(
        title: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a ToDo',
          ),
          controller: controller,
          onChanged: BlocProvider.of<TodoCubit>(context).titleOnChange,
        ),
        trailing: IconButton(
          color: Colors.indigo,
          icon: const Icon(Icons.add),
          onPressed: () {
            BlocProvider.of<TodoCubit>(context).addTodo();
            controller.clear();
          },
        ),
      ),
    );
  }
}
