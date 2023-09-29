import 'package:flutter/material.dart';
import 'package:react_state/react_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counter = 0.rx;
  final counterRenders = 0.rx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                React(() {
                  final counter = this.counter.value;
                  Future.delayed(const Duration(milliseconds: 1), () {
                    ++counterRenders.value;
                  });

                  return Text(counter.toString());
                }),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    counter.value++;
                  },
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 12),
                React(() {
                  final counterRenders = this.counterRenders.value;

                  return Text('(Renders: $counterRenders)');
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
