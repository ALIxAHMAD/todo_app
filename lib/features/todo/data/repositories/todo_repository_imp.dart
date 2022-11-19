// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:todo_app/core/util/result/failure.dart';
import 'package:todo_app/core/util/result/success.dart';
import 'package:todo_app/features/todo/data/datasources/data_source.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class ToDoRepositoryImp implements ToDoRepository {
  final DataSource dataSource;

  ToDoRepositoryImp({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, Success>> addTodo(
    String title,
  ) async {
    try {
      await dataSource.addToDo(
        title,
      );
      return Right(Success());
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteTodo(id) async {
    try {
      await dataSource.deleteToDo(id);
      return Right(Success());
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ToDos>> getTodos() async {
    try {
      final todos = await dataSource.getToDos();
      return Right(todos.toEntityTodos());
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> updateTodo(int id, bool isDone) async {
    try {
      await dataSource.updateToDo(id, isDone);
      return Right(Success());
    } catch (e) {
      return Left(DataFailure(e.toString()));
    }
  }
}
