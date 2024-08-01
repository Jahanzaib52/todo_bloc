import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

class FilteredTodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CalculateFilteredTodoEvent extends FilteredTodoEvent {
  final List<Todo> filteredTodoList;
  CalculateFilteredTodoEvent({required this.filteredTodoList});
  @override
  List<Object> get props => [filteredTodoList];
}
