import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData.dark(),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  TodoListScreenState createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  // List of tasks
  List<String> tasks = [
    'Buy groceries',
    'Walk home',
    'Finish Flutter project',
    'Call mom',
    'Feed cat',
  ];

  // Controller for the task input field
  final TextEditingController _taskController = TextEditingController();

  // Function to add a new task
  void _addTask() {
    String newTask = _taskController.text.trim();
    if (newTask.isNotEmpty) {
      setState(() {
        tasks.add(newTask); // Add the new task to the list
      });
      _taskController.clear(); // Clear the input field
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task added: $newTask'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Function to delete a task
  void _deleteTask(int index) {
    String deletedTask = tasks[index];
    setState(() {
      tasks.removeAt(index); // Remove the task at the given index
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted: $deletedTask'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("To-do App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Search button pressed!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.list, size: 40, color: Colors.blue),
                    SizedBox(width: 10),
                    Text(
                      'My Tasks',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Task List Section
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.task, color: Colors.green),
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteTask(index); // Delete the task
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // Add Task Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask, // Add the task
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}