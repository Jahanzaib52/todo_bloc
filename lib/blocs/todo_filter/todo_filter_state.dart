import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  const TodoFilterState({required this.filter});
  factory TodoFilterState.initial() {
    return const TodoFilterState(filter: Filter.all);
  }
  @override
  List<Object> get props => [filter];
  TodoFilterState copyWith({Filter? filter}) {
    return TodoFilterState(filter: filter ?? this.filter);
  }
}