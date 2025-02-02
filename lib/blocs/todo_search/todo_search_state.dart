import 'package:equatable/equatable.dart';

class TodoSearchState extends Equatable {
  final String searchTerm;
  const TodoSearchState({required this.searchTerm});
  factory TodoSearchState.initial() {
    return const TodoSearchState(searchTerm: "");
  }
  @override
  List<Object> get props => [searchTerm];
  TodoSearchState copyWith({String? searchTerm}) {
    return TodoSearchState(searchTerm: searchTerm ?? this.searchTerm);
  }
}