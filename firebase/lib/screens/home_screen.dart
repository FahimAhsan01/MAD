import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => const TodoDialog(),
        ),
      ),
      body: const TodoList(),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todos;
    
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (ctx, i) => ListTile(
        title: Text(todos[i].title),
        subtitle: Text(todos[i].description),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => context.read<TodoProvider>().deleteTodo(todos[i].id),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (ctx) => TodoDialog(todo: todos[i]),
        ),
      ),
    );
  }
}