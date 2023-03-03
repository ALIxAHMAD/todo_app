import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/repositories/todo_repository.dart';
import '../cubit/todo_cubit.dart';

import '../widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = TodoCubit(
      toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
    );
    cubit.init();
  }

  @override
  void dispose() {
    cubit.close();
    Hive.box('ToDo').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoCubit>(
      create: (_) => cubit,
      child: const ToDoScreenView(),
    );
  }
}

class ToDoScreenView extends StatelessWidget {
  const ToDoScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("ToDos"),
          ),
          body: ListView.builder(
            itemCount: state.toDos.toDos.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.newline,
                            onChanged: BlocProvider.of<TodoCubit>(context)
                                .titleOnChange,
                            maxLines: 10,
                            minLines: 1,
                            decoration: const InputDecoration(
                              hintText: "Note",
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<TodoCubit>(context).addTodo();
                            controller.clear();
                          },
                          child: const Text("Add"),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              }
              final todo = state.toDos.toDos[index - 1];
              return ToDoTile(
                id: todo.id,
                isDone: todo.isDone,
                title: todo.title,
              );
            },
          ),
        );
      },
    );
  }
}
