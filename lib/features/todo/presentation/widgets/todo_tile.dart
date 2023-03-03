import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/features/todo/presentation/widgets/update_todo.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                BlocProvider.of<TodoCubit>(context).deleteToDo(id);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: GestureDetector(
          onLongPress: () {
            final cubit = BlocProvider.of<TodoCubit>(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Widget dialog = UpdateToDoDialog(
                  initText: title,
                  id: id,
                  isDone: isDone,
                );

                // Provide the existing BLoC instance to the new route (the dialog)
                return BlocProvider<TodoCubit>.value(
                  value: cubit, //
                  child: dialog,
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // checkbox
                Checkbox(
                  value: isDone,
                  onChanged: (value) {
                    BlocProvider.of<TodoCubit>(context)
                        .updateTodo(id, !isDone, title);
                  },
                  activeColor: Colors.black,
                ),

                // task name
                Text(
                  title,
                  style: TextStyle(
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
