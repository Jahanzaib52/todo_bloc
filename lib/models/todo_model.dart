import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum Filter {
  all,
  active,
  complete,
}

Uuid uuid = const Uuid();

class Todo extends Equatable {
  final String id;
  final String desc;
  final bool complete;
  Todo({String? id, required this.desc, this.complete = false})
      : id = id ?? uuid.v4();
  @override
  List<Object> get props => [id, desc, complete];
  @override
  String toString() {
    return "Todo(desc: $desc,id: $id,complete: $complete)";
  }
}
