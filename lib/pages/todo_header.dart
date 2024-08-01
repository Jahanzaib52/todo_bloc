import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/active_todo/active_todo_state.dart';
import 'package:todo_bloc/blocs/blocs.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "TODO",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        BlocBuilder<ActiveTodoBloc, ActiveTodoState>(
          builder: (context, state) {
            return Text(
              "${state.activeTodo} tasks left",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            );
          },
        ),
      ],
    );
  }
}
