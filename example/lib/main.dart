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
            ),
            const Divider(),
            const _ComputeExample(),
            const Divider(),
            const _ComplexComputeExample(),
            const Divider(),
            const _DebouncedExample(),
          ],
        ),
      ),
    );
  }
}

class _ComputeExample extends StatefulWidget {
  const _ComputeExample();

  @override
  State<_ComputeExample> createState() => _ComputeExampleState();
}

class _ComputeExampleState extends State<_ComputeExample> {
  // IDEATION:
  // final textEditingController = TextEditingController();
  // final text = ReactObject.fromValueNotifier<String>(textEditingController);

  final text = ''.rx;
  late final isNumber = React.computed(() {
    return num.tryParse(text.value) != null;
  });
  final isNumberRenders = 0.rx;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            onChanged: (value) {
              text.value = value;
            },
          ),
        ),
        const SizedBox(width: 12),
        React(() {
          final text = this.text.value;

          return Text(text);
        }),
        const SizedBox(width: 12),
        React(() {
          final isNumber = this.isNumber.value;
          Future.delayed(const Duration(milliseconds: 1), () {
            ++isNumberRenders.value;
          });

          return Text('(isNumber: $isNumber)');
        }),
        React(() {
          return Text('(Renders: ${isNumberRenders.value})');
        })
      ],
    );
  }
}

class _ComplexComputeExample extends StatefulWidget {
  const _ComplexComputeExample();

  @override
  State<_ComplexComputeExample> createState() => __ComplexComputeExampleState();
}

class __ComplexComputeExampleState extends State<_ComplexComputeExample> {
  final number1 = 1.rx;
  final number2 = 2.rx;
  final number3 = 3.rx;
  final renders = 0.rx;
  final runs = 0.rx;

  late final sum = React.computed(() {
    Future.delayed(const Duration(milliseconds: 10), () => runs.value++);
    return number1.value + number2.value + number3.value;
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        React(() {
          return Text(number1.value.toString());
        }),
        const SizedBox(width: 12),
        React(() {
          return Text(number2.value.toString());
        }),
        const SizedBox(width: 12),
        React(() {
          return Text(number3.value.toString());
        }),
        const SizedBox(width: 12),
        React(() {
          final sum = this.sum.value;
          Future.delayed(const Duration(milliseconds: 1), () {
            ++renders.value;
          });

          return Text('(sum: $sum)');
        }),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            number1.value++;
            number2.value++;
            number3.value++;
          },
          child: const Text('Increase all values'),
        ),
        const SizedBox(width: 12),
        React(() {
          return Text('(Renders: ${renders.value})');
        }),
        const SizedBox(width: 12),
        React(() {
          return Text('(Runs: ${runs.value})');
        }),
      ],
    );
  }
}

class _DebouncedExample extends StatefulWidget {
  const _DebouncedExample();

  @override
  State<_DebouncedExample> createState() => _DebouncedExampleState();
}

class _DebouncedExampleState extends State<_DebouncedExample> {
  final text = ''.rxDebounced(const Duration(milliseconds: 400));
  final renders = 0.rx;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            onChanged: (value) {
              text.value = value;
            },
          ),
        ),
        const SizedBox(width: 12),
        React(() {
          Future.delayed(const Duration(milliseconds: 1), () {
            ++renders.value;
          });
          return Text(text.value);
        }),
        const SizedBox(width: 12),
        React(() {
          final renders = this.renders.value;
          return Text('(Renders: $renders)');
        }),
      ],
    );
  }
}
