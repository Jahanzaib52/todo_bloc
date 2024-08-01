import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/filtered_todo/filtered_todo_event.dart';
import 'package:todo_bloc/blocs/filtered_todo/filtered_todo_state.dart';
import 'package:todo_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_bloc/blocs/todo_filter/todo_filter_state.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_state.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_state.dart';
import 'package:todo_bloc/models/todo_model.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  final List<Todo> initialFilteredTodoList;
  final TodoFilterBloc todoFilterBloc;
  final TodoListBloc todoListBloc;
  final TodoSearchBloc todoSearchBloc;
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoListSubscription;
  late final StreamSubscription todoSearchSubscription;
  FilteredTodoBloc({
    required this.initialFilteredTodoList,
    required this.todoFilterBloc,
    required this.todoListBloc,
    required this.todoSearchBloc,
  }) : super(FilteredTodoState(filteredTodoList: initialFilteredTodoList)) {
    todoFilterSubscription =
        todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodo();
    });
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      setFilteredTodo();
    });
    todoSearchSubscription =
        todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodo();
    });
    on<CalculateFilteredTodoEvent>((event, emit) {
      emit(state.copyWith(filteredTodoList: event.filteredTodoList));
    });
  }
  void setFilteredTodo() {
    List<Todo> newFilteredTodoList = [];
    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        newFilteredTodoList = todoListBloc.state.todoList
            .where((Todo todo) => !todo.complete)
            .toList();
        break;
      case Filter.complete:
        newFilteredTodoList = todoListBloc.state.todoList
            .where((Todo todo) => todo.complete)
            .toList();
        break;
      case Filter.all:
      default:
        newFilteredTodoList = todoListBloc.state.todoList;
    }
    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      newFilteredTodoList = newFilteredTodoList
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }
    add(CalculateFilteredTodoEvent(filteredTodoList: newFilteredTodoList));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    todoSearchSubscription.cancel();
    return super.close();
  }
}
