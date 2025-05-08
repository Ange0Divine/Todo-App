import 'package:flutter/material.dart';

class TodoDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> todo;
  final Function(Map<String, dynamic>) onUpdate;

  const TodoDetailsScreen({required this.todo, required this.onUpdate});

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  late Map<String, dynamic> currentTodo;

  @override
  void initState() {
    super.initState();
    currentTodo = Map<String, dynamic>.from(widget.todo);
  }

  void _showEditDialog() {
    final titleController = TextEditingController(text: currentTodo['title']);
    final descController = TextEditingController(text: currentTodo['description']);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  currentTodo['title'] = titleController.text.trim();
                  currentTodo['description'] = descController.text.trim();
                });
                widget.onUpdate(currentTodo);
                Navigator.of(context).pop(); // close dialog
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentTodo['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              currentTodo['description'] != ''
                  ? currentTodo['description']
                  : 'No description provided.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Created: ${currentTodo['createdAt'].toString().split(".")[0]}',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              'Status: ${currentTodo['isDone'] ? "Completed ✅" : "Pending ⏳"}',
              style: TextStyle(
                color: currentTodo['isDone'] ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}