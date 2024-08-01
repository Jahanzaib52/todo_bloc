import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todoList;
  const TodoListState({required this.todoList});
  factory TodoListState.initial() {
    return TodoListState(
      todoList: [
        Todo(id: "1", desc: "Goto Gym", complete: false),
        Todo(id: "2", desc: "Trip to Hunza", complete: true),
        Todo(id: "3", desc: "Goto Bazzar", complete: false),
        Todo(id: "4", desc: "Goto Mandi", complete: false),
        Todo(id: "5", desc: "Do Homework", complete: false),
      ],
    );
  }
  @override
  List<Object> get props => [todoList];
  @override
  String toString() {
    return "TodoListState(todoList: $todoList)";
  }

  TodoListState copyWith({List<Todo>? todoList}) {
    return TodoListState(todoList: todoList ?? this.todoList);
  }
}