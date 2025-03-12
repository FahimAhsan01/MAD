import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  HomepageState createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  // List of tasks with title, due date, priority, and completion status
  List<Map<String, dynamic>> tasks = [
    {
      "title": "Wake up",
      "dueDate": DateTime.now().add(const Duration(days: 1)),
      "priority": "High",
      "completed": false
    },
    {
      "title": "Brush up",
      "dueDate": DateTime.now().add(const Duration(days: 1)),
      "priority": "Medium",
      "completed": false
    },
    {
      "title": "Breakfast",
      "dueDate": DateTime.now().add(const Duration(days: 1)),
      "priority": "Low",
      "completed": false
    },
  ];

  // Controller for the search bar
  final TextEditingController _searchController = TextEditingController();

  // Function to show the task creation dialog
  void _showAddTaskDialog() {
    final TextEditingController titleController = TextEditingController();
    DateTime? dueDate;
    String priority = "Low";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Enter task title",
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text("Due Date"),
                subtitle: Text(
                  dueDate == null
                      ? "No date selected"
                      : "${dueDate!.toLocal()}".split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      dueDate = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: priority,
                items: ["Low", "Medium", "High"].map((String priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Priority",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty && dueDate != null) {
                  setState(() {
                    tasks.add({
                      "title": titleController.text.trim(),
                      "dueDate": dueDate,
                      "priority": priority,
                      "completed": false
                    });
                  });
                  Navigator.pop(context); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Task added: ${titleController.text.trim()}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text("Add Task"),
            ),
          ],
        );
      },
    );
  }

  // Function to delete a task
  void _deleteTask(int index) {
    String deletedTask = tasks[index]["title"];
    setState(() {
      tasks.removeAt(index); // Remove the task at the given index
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted: $deletedTask'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Function to toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"]; // Toggle completion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do App"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          // Search Bar with Limited Width
          Container(
            width: 200, // Fixed width for the search bar
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search tasks...",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Perform search functionality here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Searching for: ${_searchController.text}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Home was pressed"),
                ));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 15),
                    Text(
                      "My Tasks for today",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: tasks[index]["completed"],
                      onChanged: (value) {
                        _toggleTaskCompletion(index); // Toggle task completion
                      },
                    ),
                    title: Text(
                      tasks[index]["title"],
                      style: TextStyle(
                        decoration: tasks[index]["completed"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      "Due: ${tasks[index]["dueDate"].toLocal().toString().split(' ')[0]}\n"
                      "Priority: ${tasks[index]["priority"]}",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _deleteTask(index); // Delete the task
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Applications was pressed"),
                ));
              },
              icon: const Icon(Icons.rectangle),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Home was pressed"),
                ));
              },
              icon: const Icon(Icons.circle),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Back was pressed"),
                ));
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Show the task creation dialog
        child: const Icon(Icons.add),
      ),
    );
  }
}