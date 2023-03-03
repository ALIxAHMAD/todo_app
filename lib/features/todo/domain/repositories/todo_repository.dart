import 'package:dartz/dartz.dart';
import '../../../../core/util/result/success.dart';
import '../entities/todo.dart';
import '../../../../core/util/result/failure.dart';

abstract class ToDoRepository {
  Future<Either<Failure, Success>> addTodo(String title);
  Future<Either<Failure, Success>> deleteTodo(int id);
  Future<Either<Failure, ToDos>> getTodos();
  Future<Either<Failure, Success>> updateTodo(
      int id, bool isDone, String title);
}
