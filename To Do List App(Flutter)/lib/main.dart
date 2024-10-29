import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List App',
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
    taskController.clear();
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the AppBar color to black
        title: Text(
          'To-Do List App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center, // Center the title text
        ),
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: Image.asset('images/back2.png'),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20), // Change label color to black
                      labelText: 'Enter a task',
                    ),
                    style: TextStyle(color: Colors.black), // Change text color to black
                    onSubmitted: (value) {
                      addTask(value);
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    addTask(taskController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  ),
                  child: Text(
                    'Add Task',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                SizedBox(width: 5,)
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(tasks[index]),
                    onDismissed: (direction) {
                      removeTask(index);
                    },
                    child: SingleChildScrollView(
                      child: Card(
                        color: Colors.black,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          title: Text(
                            tasks[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[200]),
                            onPressed: () {
                              removeTask(index);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
