import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/blocs.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_event.dart';
import 'package:todo_bloc/models/todo_model.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodoBloc>().state.filteredTodoList;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todos[index].id),
          background: showBackground(false),
          secondaryBackground: showBackground(true),
          onDismissed: (direction) {
            context
                .read<TodoListBloc>()
                .add(RemoveTodoListEvent(todo: todos[index]));
          },
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Are you Sure?"),
                  content: const Text("Do you really want to delete?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          },
          child: TodoItem(todo: todos[index]),
        );
      },
    );
  }
}

Widget showBackground(bool dragRight) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    color: Colors.red,
    alignment: dragRight == true ? Alignment.centerRight : Alignment.centerLeft,
    child: const Icon(Icons.delete),
  );
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final TextEditingController newTodoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            newTodoController.text = widget.todo.desc;
            bool error = false;
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text("Edit Todo"),
                content: TextField(
                  controller: newTodoController,
                  autofocus: true,
                  decoration: InputDecoration(
                    // error: error == true
                    //     ? const Text("Value cannot be empty")
                    //     : null,
                    errorText: error == true ? "Value cannot be empty" : null,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      error = newTodoController.text.isEmpty ? true : false;
                      setState(() {});
                      if (error == false) {
                        context.read<TodoListBloc>().add(EditTodoListEvent(
                            id: widget.todo.id,
                            desc: newTodoController.text.trim()));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Edit"),
                  ),
                ],
              );
            });
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.complete,
        onChanged: (bool? checked) {
          context
              .read<TodoListBloc>()
              .add(ToggleTodoListEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
