import 'package:flutter/material.dart';

class TodoItem {
  String task;
  bool isDone;

  TodoItem({required this.task, this.isDone = false});
}

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Todo App'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: TodoListScreen(),
          ),
        ),
      ),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreen createState() => _TodoListScreen();
}

class _TodoListScreen extends State<TodoListScreen> {
  List<TodoItem> todoList = [];
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  void addNewItem(String value) {
    setState(() {
      todoList.add(TodoItem(task: value));
    });
  }

  void removeItem(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void toggleDone(int index) {
    setState(() {
      TodoItem item = todoList.elementAt(index);
      item.isDone = !item.isDone;
    });
  }

  void clearAndFocus() {
    controller.clear();
    focusNode.requestFocus();
  }

  Widget buildTodoItem(TodoItem item, int index) {
    return Card(
      child: ListTile(
        title: Text(
            item.task,
          style: TextStyle(
            color: item.isDone ? Colors.red: null,
            decoration: item.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: item.isDone,
          onChanged: (_) {
            toggleDone(index);
          },
        ),
        onLongPress: () {
          removeItem(index);
        },
        onTap: () {
          toggleDone(index);
        },
      ),
    );
  }

  Widget buildTodoList() {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return buildTodoItem(todoList.elementAt(index), index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: buildTodoList()),
        Container(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Add a new task',
            ),
            controller: controller,
            focusNode: focusNode,
            onSubmitted: (val) {
              addNewItem(val);
              clearAndFocus();
            },
          ),
        )
      ],
    );
  }
}