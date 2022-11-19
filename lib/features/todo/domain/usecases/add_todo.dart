import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/result/failure.dart';
import 'package:todo_app/core/util/result/success.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class AddTodoUseCase {
  final ToDoRepository repository;

  AddTodoUseCase(this.repository);

  Future<Either<Failure, Success>> call(String title) {
    return repository.addTodo(title);
  }
}
