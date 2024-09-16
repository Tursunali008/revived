import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revived/model/todo.dart';
import 'package:revived/providers/todos_provider.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({super.key, required this.todo});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = todo.title;
    _dateController.text = todo.dateTime.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: todo.dateTime,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  _dateController.text = pickedDate.toIso8601String();
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Todo updatedTodo = Todo(
                  id: todo.id,
                  title: _titleController.text,
                  dateTime: DateTime.parse(_dateController.text),
                  isDone: todo.isDone,
                );

                Provider.of<TodosNotifier>(context, listen: false)
                    .editTodo(updatedTodo);
                Navigator.of(context).pop();
              },
              child: const Text('Update Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
