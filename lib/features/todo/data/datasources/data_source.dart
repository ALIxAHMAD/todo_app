import 'package:todo_app/features/todo/data/models/todo_model.dart';

abstract class DataSource {
  Future<ToDosModel> getToDos();
  Future<void> addToDo(String title);
  Future<void> deleteToDo(int id);
  Future<void> updateToDo(int id, bool isDone);
}
