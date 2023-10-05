import 'package:flutter/material.dart';
import 'package:react_state/react_state.dart';

class TodoListExample extends StatefulWidget {
  const TodoListExample({super.key});

  @override
  State<TodoListExample> createState() => _TodoListExampleState();
}

class _TodoListExampleState extends State<TodoListExample> {
  final todos = <String>[
    "Buy food for the dog",
    "Buy milk",
    "Test React State",
  ].ref;
  final completedTodos = [].ref;

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Add a new todo',
              ),
              controller: textEditingController,
              onFieldSubmitted: (text) {
                todos.insert(0, text);
                textEditingController.clear();
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: React(() {
                return Column(
                  children: todos
                      .map(
                        (todo) => ListTile(
                          title: Text(todo),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => todos.remove(todo),
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
