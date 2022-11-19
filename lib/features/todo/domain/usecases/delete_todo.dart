import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/result/failure.dart';
import 'package:todo_app/core/util/result/success.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class DeleteToDoUseCase {
  final ToDoRepository repository;

  DeleteToDoUseCase(this.repository);

  Future<Either<Failure, Success>> call(int id) {
    return repository.deleteTodo(id);
  }
}
