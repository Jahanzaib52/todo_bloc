import 'package:flutter/material.dart';
import 'package:todo_bloc/pages/create_todo.dart';
import 'package:todo_bloc/pages/search_and_filter_todo.dart';
import 'package:todo_bloc/pages/show_todo.dart';
import 'package:todo_bloc/pages/todo_header.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                SizedBox(height: 20),
                SearchAndFilterTodo(),
                ShowTodo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
