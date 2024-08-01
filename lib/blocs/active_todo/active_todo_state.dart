import 'package:equatable/equatable.dart';

class ActiveTodoState extends Equatable {
  final int activeTodo;
  const ActiveTodoState({required this.activeTodo});
  factory ActiveTodoState.initial() {
    return const ActiveTodoState(activeTodo: 4);
  }
  @override
  List<Object> get props => [activeTodo];
  ActiveTodoState copyWith({int? activeTodo}) {
    return ActiveTodoState(activeTodo: activeTodo ?? this.activeTodo);
  }
}
