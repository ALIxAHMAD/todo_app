import 'package:dartz/dartz.dart';
import '../../../../core/util/result/failure.dart';
import '../../../../core/util/result/success.dart';
import '../repositories/todo_repository.dart';

class AddTodoUseCase {
  final ToDoRepository repository;

  AddTodoUseCase(this.repository);

  Future<Either<Failure, Success>> call(String title) {
    return repository.addTodo(title);
  }
}
