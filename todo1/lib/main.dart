import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Homepage(),
    );
  }
}

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
  Homepage({super.key});

  List tasks = [
    "Wake up",
    "Brush up",
    "Breakfast",
    "Go to workplace",
    "Work till lunch",
    "Have lunch",
    "Work again",
    "Leave workplace",
    "Come home",
    "Feed and play with cat",
    "Sleep",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do App"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Search was pressed"),
                duration: Duration(
                  seconds: 1,
                ),
              ));
            },
            icon: const Icon(Icons.search))
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
              )
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Home was pressed")));
              },
            )
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
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                  leading: const Icon(Icons.task_alt),
                  title: Text(tasks[index]),
                  trailing: IconButton(
                    onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${tasks[index]} was deleted"),
                      duration: const Duration(seconds: 1),
                      ));
                    },
                    icon: const Icon(Icons.delete_forever),
                  ),
                  ),
                );
              }
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Applications was pressed")));
              },
              icon: const Icon(Icons.rectangle)),
            IconButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Home was pressed")));
              },
              icon: const Icon(Icons.circle)),
            IconButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Back was pressed")));
              },
              icon: const Icon(Icons.arrow_back)),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Add task pressed")));
        },
        child:const Icon(Icons.add),
        ),
    );
  }
}