import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';

class AddToDoCard extends StatelessWidget {
  final TextEditingController controller;
  const AddToDoCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                onChanged: BlocProvider.of<TodoCubit>(context).titleOnChange,
                decoration: const InputDecoration(hintText: 'Enter ToDo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  BlocProvider.of<TodoCubit>(context).addTodo();
                  controller.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
