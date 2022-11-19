import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/result/failure.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class GetToDosUseCase {
  final ToDoRepository repository;

  GetToDosUseCase(this.repository);

  Future<Either<Failure, ToDos>> call() {
    return repository.getTodos();
  }
}
