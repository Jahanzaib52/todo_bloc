import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_event.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<SetSearchTodoEvent>((event, emit) {
      emit(state.copyWith(searchTerm: event.searchTerm));
    }, transformer: debounce(const Duration(milliseconds: 2000)));
  }
  EventTransformer<SetSearchTodoEvent> debounce<SetSearchTodoEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
