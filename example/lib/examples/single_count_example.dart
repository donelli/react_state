import 'package:flutter/material.dart';
import 'package:react_state/react_state.dart';

class SingleCountExample extends ReactStateful {
  SingleCountExample({super.key});

  final count = 0.ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single count example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            React(() {
              final count = this.count.value;
              return Text(count.toString());
            }),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ++count.value;
              },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
