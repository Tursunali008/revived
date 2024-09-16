import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revived/providers/todos_provider.dart';
import 'package:revived/screens/add_todo.dart';
import 'package:revived/screens/edit_screen.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TodosNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (notifier.errorMessage.isNotEmpty) {
            return Center(child: Text(notifier.errorMessage));
          }
          return ListView.builder(
            itemCount: notifier.todos.length,
            itemBuilder: (context, index) {
              final todo = notifier.todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text('Date: ${todo.dateTime}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditTodoScreen(todo: todo)),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        notifier.deleteTodo(todo.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
