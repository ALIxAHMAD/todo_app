// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final String title;
  final String errorMessage;
  final ToDos toDos;

  const TodoState({
    required this.title,
    required this.errorMessage,
    required this.toDos,
  });

  factory TodoState.initial() {
    return const TodoState(
      title: '',
      errorMessage: '',
      toDos: ToDos(toDos: []),
    );
  }

  @override
  List<Object> get props => [title, errorMessage, toDos];

  TodoState copyWith({
    String? title,
    String? errorMessage,
    ToDos? toDos,
  }) {
    return TodoState(
      errorMessage: errorMessage ?? this.errorMessage,
      title: title ?? this.title,
      toDos: toDos ?? this.toDos,
    );
  }
}
