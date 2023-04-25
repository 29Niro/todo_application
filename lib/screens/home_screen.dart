import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _todoList = <String>[];

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoList.add(task);
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mark "${_todoList[index]}" as done?'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoList() {
    if ((_todoList.isEmpty)) {
      return Center(
        child: Column(
          children: [
            Image.asset('assets/Checklist-rafiki-1.png'),
            const Text('What are you planning to do today?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Tap the + button to add a task.',
                style: TextStyle(fontSize: 15)),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index < _todoList.length) {
            return _buildTodoItem(_todoList[index], index);
          }
          return null;
        },
      );
    }
  }

  Widget _buildTodoItem(String todoText, int index) {
    return InkWell(
      onTap: () {
        _promptRemoveTodoItem(index);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 120, 121, 241).withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        key: Key(todoText),
        height: 50,
        child: Align(alignment: Alignment.centerLeft, child: Text(todoText)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 120, 121, 241),
        elevation: 0,
        title: const Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 120, 121, 241),
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      MaterialPageRoute<AlertDialog>(
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task'),
            content: TextField(
              autofocus: true,
              onSubmitted: (String str) {
                _addTodoItem(str);
                Navigator.of(context).pop();
              },
              decoration: const InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
