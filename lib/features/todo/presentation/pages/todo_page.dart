import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_tile.dart';

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
          backgroundColor: Colors.green[100],
          appBar: AppBar(title: const Text('ToDo')),
          body: ListView.builder(
            itemCount: state.toDos.toDos.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
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
                            onChanged: BlocProvider.of<TodoCubit>(context)
                                .titleOnChange,
                            decoration:
                                const InputDecoration(hintText: 'Enter ToDo'),
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
              final toDo = state.toDos.toDos[index - 1];
              return ToDoTile(
                id: toDo.id,
                isDone: toDo.isDone,
                title: toDo.title,
              );
            },
          ),
        );
      },
    );
  }
}
