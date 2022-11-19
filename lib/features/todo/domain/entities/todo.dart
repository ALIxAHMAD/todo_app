// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ToDo extends Equatable {
  final String title;
  final bool isDone;
  final int id;

  const ToDo({
    required this.title,
    required this.isDone,
    required this.id,
  });

  @override
  List<Object> get props => [title, isDone, id];
}

class ToDos extends Equatable {
  final List<ToDo> toDos;

  const ToDos({
    required this.toDos,
  });

  @override
  List<Object> get props => [toDos];
}
