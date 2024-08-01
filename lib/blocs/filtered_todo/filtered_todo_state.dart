import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

class FilteredTodoState extends Equatable {
  final List<Todo> filteredTodoList;
  const FilteredTodoState({required this.filteredTodoList});
  factory FilteredTodoState.initial() {
    return const FilteredTodoState(filteredTodoList: []);
  }
  @override
  List<Object> get props => [filteredTodoList];
  FilteredTodoState copyWith({List<Todo>? filteredTodoList}) {
    return FilteredTodoState(
        filteredTodoList: filteredTodoList ?? this.filteredTodoList);
  }
}
