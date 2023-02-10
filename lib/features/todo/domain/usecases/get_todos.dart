import 'package:dartz/dartz.dart';

import '../../../../core/util/result/failure.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetToDosUseCase {
  final ToDoRepository repository;

  GetToDosUseCase(this.repository);

  Future<Either<Failure, ToDos>> call() {
    return repository.getTodos();
  }
}
