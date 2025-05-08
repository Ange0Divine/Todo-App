import 'package:flutter/material.dart';
import 'todo_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> todos = [];
  String filter = 'All';

  void _addTodo(String title, String? description, DateTime? dueDate) {
    setState(() {
      todos.add({
        'title': title,
        'description': description ?? '',
        'isDone': false,
        'createdAt': DateTime.now(),
        'dueDate': dueDate,
      });
    });
  }

  void _toggleDone(int index) {
    setState(() {
      todos[index]['isDone'] = !todos[index]['isDone'];
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void _updateTodo(int index, Map<String, dynamic> updatedTodo) {
    setState(() {
      todos[index] = updatedTodo;
    });
  }

  void _openAddTodoDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    DateTime? selectedDueDate;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text('Add New Todo'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      labelText: 'Description (optional)',
                      prefixIcon: Icon(Icons.description),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text(
                      selectedDueDate == null
                          ? 'No due date selected'
                          : 'Due: ${selectedDueDate!.toLocal().toString().split(' ')[0]}',
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setStateDialog(() => selectedDueDate = picked);
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  String title = titleController.text.trim();
                  String desc = descController.text.trim();
                  if (title.isNotEmpty) {
                    _addTodo(title, desc, selectedDueDate);
                  }
                  Navigator.of(ctx).pop();
                },
                icon: Icon(Icons.save),
                label: Text('Save'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              )
            ],
          );
        });
      },
    );
  }

  List<Map<String, dynamic>> get filteredTodos {
    if (filter == 'All') return todos;
    if (filter == 'Completed') return todos.where((t) => t['isDone']).toList();
    if (filter == 'Pending') return todos.where((t) => !t['isDone']).toList();
    return todos;
  }

  Widget _buildTodoTile(int index) {
    final todo = todos[index];

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteTodo(index),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TodoDetailsScreen(
                  todo: todo,
                  onUpdate: (updatedTodo) => _updateTodo(index, updatedTodo),
                ),
              ),
            );
          },
          leading: Checkbox(
            value: todo['isDone'],
            onChanged: (_) => _toggleDone(index),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          title: Text(
            todo['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: todo['isDone'] ? TextDecoration.lineThrough : null,
              color: todo['isDone'] ? Colors.grey : Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo['description'] != '')
                Text(todo['description'], style: TextStyle(fontStyle: FontStyle.italic)),
              if (todo['dueDate'] != null)
                Text(
                  'Due: ${todo['dueDate'].toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),
                ),
            ],
          ),
          trailing: Icon(
            todo['isDone'] ? Icons.check_circle : Icons.radio_button_unchecked,
            color: todo['isDone'] ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredTodos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${widget.userName}!'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              widget.userName[0].toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterChip(
                  label: Text('All'),
                  selected: filter == 'All',
                  onSelected: (_) => setState(() => filter = 'All'),
                ),
                FilterChip(
                  label: Text('Completed'),
                  selected: filter == 'Completed',
                  onSelected: (_) => setState(() => filter = 'Completed'),
                ),
                FilterChip(
                  label: Text('Pending'),
                  selected: filter == 'Pending',
                  onSelected: (_) => setState(() => filter = 'Pending'),
                ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(child: Text('No todos match this filter.'))
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, filteredIndex) {
                final actualIndex = todos.indexOf(filtered[filteredIndex]);
                return _buildTodoTile(actualIndex);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddTodoDialog,
        icon: Icon(Icons.add),
        label: Text("Add Todo"),
      ),
    );
  }
}