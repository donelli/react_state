// ignore_for_file: avoid_print

import 'package:example/examples/single_count_example.dart';
import 'package:example/examples/to_do_list_example.dart';
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
  final counter = 0.ref;
  final counterRenders = 0.ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Button(
              label: 'Single count example',
              pageBuilder: () {
                return SingleCountExample();
              },
            ),
            _Button(
              label: 'TODO List',
              pageBuilder: () {
                return const TodoListExample();
              },
            ),
            // Row(
            //   children: [
            //     React(() {
            //       final counter = this.counter.value;
            //       Future.delayed(const Duration(milliseconds: 1), () {
            //         ++counterRenders.value;
            //       });

            //       return Text(counter.toString());
            //     }),
            //     const SizedBox(width: 12),
            //     ElevatedButton(
            //       onPressed: () {
            //         counter.value++;
            //       },
            //       child: const Text('Increment'),
            //     ),
            //     const SizedBox(width: 12),
            //     React(() {
            //       final counterRenders = this.counterRenders.value;

            //       return Text('(Renders: $counterRenders)');
            //     }),
            //   ],
            // ),
            // const Divider(),
            // const _ComputeExample(),
            // const Divider(),
            // const _ComplexComputeExample(),
            // const Divider(),
            // _DebouncedExample(),
            // const Divider(),
            // const _WithController(),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.pageBuilder,
  });

  final String label;
  final Widget Function() pageBuilder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(label),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => pageBuilder()),
        );
      },
    );
  }
}

// class _ComputeExample extends StatefulWidget {
//   const _ComputeExample();

//   @override
//   State<_ComputeExample> createState() => _ComputeExampleState();
// }

// class _ComputeExampleState extends State<_ComputeExample> {
//   // IDEATION:
//   // final textEditingController = TextEditingController();
//   // final text = ReactObject.fromValueNotifier<String>(textEditingController);

//   final text = ''.rx;
//   late final isNumber = React.computed(() {
//     return num.tryParse(text.value) != null;
//   });
//   final isNumberRenders = 0.rx;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 200,
//           child: TextFormField(
//             onChanged: (value) {
//               text.value = value;
//             },
//           ),
//         ),
//         const SizedBox(width: 12),
//         React(() {
//           final text = this.text.value;

//           return Text(text);
//         }),
//         const SizedBox(width: 12),
//         React(() {
//           final isNumber = this.isNumber.value;
//           Future.delayed(const Duration(milliseconds: 1), () {
//             ++isNumberRenders.value;
//           });

//           return Text('(isNumber: $isNumber)');
//         }),
//         React(() {
//           return Text('(Renders: ${isNumberRenders.value})');
//         })
//       ],
//     );
//   }
// }

// class _ComplexComputeExample extends StatefulWidget {
//   const _ComplexComputeExample();

//   @override
//   State<_ComplexComputeExample> createState() => __ComplexComputeExampleState();
// }

// class __ComplexComputeExampleState extends State<_ComplexComputeExample> {
//   final number1 = 1.rx;
//   final number2 = 2.rx;
//   final number3 = 3.rx;
//   final renders = 0.rx;
//   final runs = 0.rx;

//   late final sum = React.computed(() {
//     Future.delayed(const Duration(milliseconds: 10), () => runs.value++);
//     return number1.value + number2.value + number3.value;
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         React(() {
//           return Text(number1.value.toString());
//         }),
//         const SizedBox(width: 12),
//         React(() {
//           return Text(number2.value.toString());
//         }),
//         const SizedBox(width: 12),
//         React(() {
//           return Text(number3.value.toString());
//         }),
//         const SizedBox(width: 12),
//         React(() {
//           final sum = this.sum.value;
//           Future.delayed(const Duration(milliseconds: 1), () {
//             ++renders.value;
//           });

//           return Text('(sum: $sum)');
//         }),
//         const SizedBox(width: 12),
//         ElevatedButton(
//           onPressed: () {
//             number1.value++;
//             number2.value++;
//             number3.value++;
//           },
//           child: const Text('Increase all values'),
//         ),
//         const SizedBox(width: 12),
//         React(() {
//           return Text('(Renders: ${renders.value})');
//         }),
//         const SizedBox(width: 12),
//         React(() {
//           return Text('(Runs: ${runs.value})');
//         }),
//       ],
//     );
//   }
// }

// class _DebouncedExample extends ReactStateful {
//   final text = ''.rxDebounced(milliseconds: 400);
//   final renders = 0.rx;

//   final computeRuns = 0.rx;
//   late final length = computed(() {
//     Future.delayed(const Duration(milliseconds: 10), () => computeRuns.value++);
//     return text.value.length;
//   });

//   @override
//   void initState() {
//     watch([text, renders], _onChangedTextOrLength);
//     watchOne(length, _onLengthChanged);
//   }

//   void _onLengthChanged(int length) {
//     print('Length changed!');
//   }

//   void _onChangedTextOrLength() {
//     print('Text or length changed!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(
//           width: 200,
//           child: TextFormField(
//             onChanged: (value) {
//               text.value = value;
//             },
//           ),
//         ),
//         const SizedBox(width: 12),
//         React(() {
//           Future.delayed(const Duration(milliseconds: 1), () {
//             ++renders.value;
//           });
//           return Text(text.value);
//         }),
//         const SizedBox(width: 12),
//         React(() {
//           final renders = this.renders.value;
//           return Text('(Renders: $renders)');
//         }),
//         React(() {
//           final length = this.length.value;
//           final computeRuns = this.computeRuns.value;

//           return Text('(computed length: $length - runs: $computeRuns )');
//         }),
//       ],
//     );
//   }
// }

// class Controller with ReactState {
//   final count = 0.rx;
//   final color = Colors.black.rx;

//   late final squared = computed(() {
//     return count.value * count.value;
//   });

//   void onInit() {
//     watchOne(count, _onCountChanged);
//   }

//   void _onCountChanged(int value) {
//     color.value = Color(
//       ((value * 0.05 / 1) * 0xFFFFFF).toInt(),
//     ).withOpacity(1.0);
//   }
// }

// class _WithController extends StatefulWidget {
//   const _WithController();

//   @override
//   State<_WithController> createState() => _WithControllerState();
// }

// class _WithControllerState extends State<_WithController> {
//   final controller = Controller();

//   @override
//   void initState() {
//     controller.onInit();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         React(() {
//           return Text(
//             controller.count.value.toString(),
//             style: TextStyle(
//               color: controller.color.value,
//             ),
//           );
//         }),
//         const SizedBox(width: 8),
//         React(() {
//           return Text(' (squared: ${controller.squared.value})');
//         }),
//         const SizedBox(width: 12),
//         ElevatedButton(
//           onPressed: () => controller.count.value++,
//           child: const Text('Increment'),
//         ),
//       ],
//     );
//   }
// }
