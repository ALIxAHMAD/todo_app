import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import '../data_source.dart';
import '../../models/todo_model.dart';

class HiveDataBase implements DataSource {
  final toDoBox = Hive.box<ToDoModel>('ToDo');

  @override
  Future<ToDosModel> getToDos() async {
    final todos = toDoBox.values.cast<ToDoModel>();
    return ToDosModel(
      toDosModel: todos
          .map<ToDoModel>(
            (e) => ToDoModel(
              title: e.title,
              id: e.id,
              isDone: e.isDone,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> deleteToDo(int id) async {
    await toDoBox.delete(id);
  }

  @override
  Future<void> addToDo(String title) async {
    if (title == '') {
      throw Exception('title must not be empty');
    } else {
      final todo = ToDoModel(
        title: title,
        isDone: false,
        id: Random().nextInt(1000000),
      );
      await toDoBox.put(todo.id, todo);
    }
  }

  @override
  Future<void> updateToDo(int id, bool isDone) async {
    var todo = toDoBox.get(id);
    if (todo == null) {
      throw Exception();
    }
    await toDoBox.put(
        todo.id,
        ToDoModel(
          title: todo.title,
          isDone: isDone,
          id: todo.id,
        ));
  }
}
