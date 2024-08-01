import 'package:equatable/equatable.dart';

class TodoSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetSearchTodoEvent extends TodoSearchEvent {
  final String searchTerm;
  SetSearchTodoEvent({required this.searchTerm});
  @override
  List<Object> get props => [searchTerm];
}
