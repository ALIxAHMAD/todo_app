import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_todo.dart';
import 'package:todo_app/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_app/features/todo/domain/usecases/update_todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final AddTodoUseCase _addTodoUseCase;
  final DeleteToDoUseCase _deleteToDoUseCase;
  final GetToDosUseCase _getToDosUseCase;
  final UpdateToDoUseCase _updateToDoUseCase;

  TodoCubit({
    required ToDoRepository toDoRepository,
  })  : _addTodoUseCase = AddTodoUseCase(toDoRepository),
        _deleteToDoUseCase = DeleteToDoUseCase(toDoRepository),
        _getToDosUseCase = GetToDosUseCase(toDoRepository),
        _updateToDoUseCase = UpdateToDoUseCase(toDoRepository),
        super(
          TodoState.initial(),
        );

  void init() async {
    final response = await _getToDosUseCase();
    response.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(toDos: r));
    });
  }

  void titleOnChange(String title) {
    emit(state.copyWith(title: title));
  }

  void addTodo() async {
    final response = await _addTodoUseCase(state.title);
    emit(state.copyWith(title: ''));
    response.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      init();
    });
  }

  deleteToDo(int id) async {
    final response = await _deleteToDoUseCase(id);
    response.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      init();
    });
  }

  updateTodo(int id, bool isDone) async {
    final response = await _updateToDoUseCase(id, isDone);
    response.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      init();
    });
  }
}
