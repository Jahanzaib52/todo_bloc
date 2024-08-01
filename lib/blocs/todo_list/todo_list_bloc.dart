import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_event.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_state.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoListEvent>(_addTodo);
    on<EditTodoListEvent>(_editTodo);
    on<ToggleTodoListEvent>(_toggleTodo);
    on<RemoveTodoListEvent>(_removeTodo);
  }
  void _addTodo(AddTodoListEvent event, Emitter<TodoListState> emit) {
    final Todo newTodo = Todo(desc: event.desc);
    final List<Todo> newTodoList = [...state.todoList, newTodo];
    emit(state.copyWith(todoList: newTodoList));
  }

  void _editTodo(EditTodoListEvent event, Emitter<TodoListState> emit) {
    final List<Todo> newTodoList = state.todoList.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(id: event.id, desc: event.desc, complete: todo.complete);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todoList: newTodoList));
  }

  void _toggleTodo(ToggleTodoListEvent event, Emitter<TodoListState> emit) {
    final List<Todo> newTodoList = state.todoList.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(id: event.id, desc: todo.desc, complete: !todo.complete);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todoList: newTodoList));
  }

  void _removeTodo(RemoveTodoListEvent event, Emitter<TodoListState> emit) {
    final List<Todo> newTodoList =
        state.todoList.where((Todo todo) => todo.id != event.todo.id).toList();
    emit(state.copyWith(todoList: newTodoList));
  }
}
