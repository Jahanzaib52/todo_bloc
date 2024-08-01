import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/active_todo/active_todo_event.dart';
import 'package:todo_bloc/blocs/active_todo/active_todo_state.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_state.dart';
import 'package:todo_bloc/models/todo_model.dart';

class ActiveTodoBloc extends Bloc<ActiveTodoEvent, ActiveTodoState> {
  final int initialActiveTodo;
  final TodoListBloc todoListBloc;
  late final StreamSubscription todoListSubscription;
  ActiveTodoBloc({required this.initialActiveTodo, required this.todoListBloc})
      : super(ActiveTodoState(activeTodo: initialActiveTodo)) {
    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      final int activeCount = todoListState.todoList
          .where((Todo todo) {
            return !todo.complete;
          })
          .toList()
          .length;
      add(CalculateActiveTodoEvent(activeTodo: activeCount));
    });
    on<CalculateActiveTodoEvent>((event, emit) {
      emit(state.copyWith(activeTodo: event.activeTodo));
    });
  }
  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
