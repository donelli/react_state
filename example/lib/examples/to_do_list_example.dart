import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
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
    "Clean the house",
  ].ref;
  final completedTodos = <String>[].ref;

  final textEditingController = TextEditingController();

  void _onTodoCompleted(int index) {
    final todo = todos.removeAt(index);
    completedTodos.insert(0, todo);
  }

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
              child: Column(
                children: [
                  React(() {
                    return Column(
                      children: todos
                          .mapIndexed(
                            (index, todo) => ListTile(
                              title: Text(todo),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.check),
                                    color: Colors.green,
                                    onPressed: () => _onTodoCompleted(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () => todos.removeAt(index),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }),
                  React(() {
                    final completedTodos = this.completedTodos.value;

                    if (completedTodos.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        const Divider(height: 24),
                        Text('Completed todos (${completedTodos.length})'),
                        ...completedTodos
                            .mapIndexed(
                              (index, todo) => ListTile(
                                title: Text(todo),
                              ),
                            )
                            .toList(),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
