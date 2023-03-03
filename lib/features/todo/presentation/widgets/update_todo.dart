// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';

class UpdateToDoDialog extends StatefulWidget {
  final String initText;
  final int id;
  final bool isDone;
  const UpdateToDoDialog({
    Key? key,
    required this.initText,
    required this.id,
    required this.isDone,
  }) : super(key: key);

  @override
  State<UpdateToDoDialog> createState() => _UpdateToDoDialogState();
}

class _UpdateToDoDialogState extends State<UpdateToDoDialog> {
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = widget.initText;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[200],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextFormField(
              controller: controller,
              onChanged: BlocProvider.of<TodoCubit>(context).titleOnChange,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                )),
                hintText: "",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                TextButton(
                    onPressed: () {
                      BlocProvider.of<TodoCubit>(context).updateTodo(
                          widget.id, widget.isDone, controller.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
