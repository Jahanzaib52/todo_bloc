import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTodoListEvent extends TodoListEvent {
  final String desc;
  AddTodoListEvent({required this.desc});
  @override
  List<Object> get props => [desc];
}

class EditTodoListEvent extends TodoListEvent {
  final String desc;
  final String id;
  EditTodoListEvent({required this.id, required this.desc});
  @override
  List<Object> get props => [id, desc];
}

class ToggleTodoListEvent extends TodoListEvent {
  final String id;
  ToggleTodoListEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class RemoveTodoListEvent extends TodoListEvent {
  final Todo todo;
  RemoveTodoListEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}
