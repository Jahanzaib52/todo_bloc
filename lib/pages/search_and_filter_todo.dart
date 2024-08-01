import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/blocs/todo_filter/todo_filter_event.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_event.dart';
import 'package:todo_bloc/models/todo_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({super.key});
  // final Debounce debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: "Search Todos...",
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? searchTerm) {
            if (searchTerm != null) {
              // debounce.run(() {
              //   context
              //       .read<TodoSearchBloc>()
              //       .add(SetSearchTodoEvent(searchTerm: searchTerm));
              // });
              context
                  .read<TodoSearchBloc>()
                  .add(SetSearchTodoEvent(searchTerm: searchTerm));
            }
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.complete),
          ],
        ),
      ],
    );
  }
}

Widget filterButton(BuildContext context, Filter filter) {
  return TextButton(
    onPressed: () {
      context.read<TodoFilterBloc>().add(ChangeTodoFilterEvent(filter: filter));
    },
    child: Text(
      filter == Filter.all
          ? "All"
          : filter == Filter.active
              ? "Active"
              : "Complete",
      style: TextStyle(
        fontSize: 18,
        color: textColor(context, filter),
      ),
    ),
  );
}

Color textColor(BuildContext context, Filter filter) {
  return context.watch<TodoFilterBloc>().state.filter == filter
      ? Colors.blue
      : Colors.grey;
}
