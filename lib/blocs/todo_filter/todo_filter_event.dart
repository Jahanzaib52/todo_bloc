import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoFilterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeTodoFilterEvent extends TodoFilterEvent {
  final Filter filter;
  ChangeTodoFilterEvent({required this.filter});
  @override
  List<Object> get props => [filter];
}
