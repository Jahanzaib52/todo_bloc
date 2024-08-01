import 'package:equatable/equatable.dart';

class ActiveTodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CalculateActiveTodoEvent extends ActiveTodoEvent {
  final int activeTodo;
  CalculateActiveTodoEvent({required this.activeTodo});
  @override
  List<Object> get props => [activeTodo];
}
