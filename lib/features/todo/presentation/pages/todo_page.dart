import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/repositories/todo_repository.dart';
import '../cubit/todo_cubit.dart';
import '../widgets/add_todo_tile.dart';
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
          backgroundColor: Colors.teal[400],
          body: Container(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 20,
              right: 20,
              left: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.playlist_add_check,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'To-Do',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  ("${state.toDos.toDos.length} ToDo"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: state.toDos.toDos.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return AddToDoTile(controller: controller);
                        }
                        final toDo = state.toDos.toDos[index - 1];
                        return ToDoTile(
                          id: toDo.id,
                          isDone: toDo.isDone,
                          title: toDo.title,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
