import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revived/providers/todos_provider.dart';

import '../model/todo.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();

  AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTodo = Todo(
                  id: '',
                  title: titleController.text,
                  dateTime: DateTime.now(),
                  isDone: false,
                );

                context.read<TodosNotifier>().addTodo(newTodo);
                Navigator.of(context).pop();
              },
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
