import 'package:dartz/dartz.dart';
import '../../../../core/util/result/failure.dart';
import '../../../../core/util/result/success.dart';
import '../repositories/todo_repository.dart';

class DeleteToDoUseCase {
  final ToDoRepository repository;

  DeleteToDoUseCase(this.repository);

  Future<Either<Failure, Success>> call(int id) {
    return repository.deleteTodo(id);
  }
}
