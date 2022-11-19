import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/result/success.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import '../../../../core/util/result/failure.dart';

abstract class ToDoRepository {
  Future<Either<Failure, Success>> addTodo(String title);
  Future<Either<Failure, Success>> deleteTodo(int id);
  Future<Either<Failure, ToDos>> getTodos();
  Future<Either<Failure, Success>> updateTodo(int id, bool isDone);
}
