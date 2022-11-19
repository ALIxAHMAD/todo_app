// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/result/failure.dart';
import 'package:todo_app/core/util/result/success.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class UpdateToDoUseCase {
  final ToDoRepository repository;

  UpdateToDoUseCase(
    this.repository,
  );

  Future<Either<Failure, Success>> call(int id, bool isDone) async {
    return await repository.updateTodo(id, isDone);
  }
}
