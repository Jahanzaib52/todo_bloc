import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/pages/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<ActiveTodoBloc>(
          create: (context) => ActiveTodoBloc(
            initialActiveTodo: context
                .read<TodoListBloc>()
                .state
                .todoList
                .where((Todo todo) => !todo.complete)
                .toList()
                .length,
            todoListBloc: context.read<TodoListBloc>(),
          ),
        ),
        BlocProvider<FilteredTodoBloc>(
          create: (context) => FilteredTodoBloc(
            initialFilteredTodoList:
                context.read<TodoListBloc>().state.todoList,
            todoFilterBloc: context.read<TodoFilterBloc>(),
            todoListBloc: context.read<TodoListBloc>(),
            todoSearchBloc: context.read<TodoSearchBloc>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoScreen(),
      ),
    );
  }
}
