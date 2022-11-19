// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:todo_app/features/todo/domain/entities/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final bool isDone;
  @HiveField(2)
  final int id;

  const ToDoModel({
    required this.title,
    required this.isDone,
    required this.id,
  });
}

class ToDosModel {
  List<ToDoModel> toDosModel;

  ToDosModel({
    required this.toDosModel,
  });

  ToDos toEntityTodos() {
    return ToDos(
      toDos: toDosModel
          .map<ToDo>(
            (e) => ToDo(
              isDone: e.isDone,
              title: e.title,
              id: e.id,
            ),
          )
          .toList(),
    );
  }
}
