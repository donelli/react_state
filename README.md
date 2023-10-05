
# React (state)

React is a state management system build for Flutter. This package was heavily inspired by Getx, but with lots of improvements and new features.

The main focus are simplicity, performance and the best development experience.

## Getting stated

Just install the package using `pub.dev`

```sh
flutter pub add react_state
```

And you are ready to go.


## Features

Just like Getx, variables needs to be declared as Reactive, and there is two ways to do that, using the powerful extensions provided by the package or using the classes directly.


#### Classes

```dart
import 'package:react_state/react_state.dart'

final string = ReactValue('');
final nullableNumber = ReactValue<int?>(null);
final map = ReactMap<String, int>();
final list = ReactList<String>();
final classValue = ReactValue<ClassA>(ClassA());
```

#### Extensions (recommended)

```dart
import 'package:react_state/react_state.dart'

final string = ''.ref;
final nullableNumber = null.ref<int>;
final map = <String, int>{}.ref;
final list = <String>[].ref;
final classValue = ClassA().ref;
```

Here is a list of extensions that exists:

```dart
// The `ref` extension exists for all Objects and created a ReactValue<T>.
final value = 'Edu'.ref;

// For null the `ref` extension exists too, but it behaves a little differently.
// It requires a type and create a ReactValue<T?> with null as the initial value.
final nullableValue = null.ref<int>()

// Similar for the example above, the `nullRef` extension creates a ReactValue<T?>
// with the provided value as initial value.
final value = 1.nullRef;

// Using the `ref` extension on a List will create a ReactList<T>.
// Which is a basically a ReactValue with lots of helper functions that are
// optimized to avoid rebuilds and work better with the reactivity system.
final list = <String>[].ref;

// The same goes for Maps, using the `ref` extension will create a ReactMap<K, V>.
final map = <String, int>{}.ref;
```

#### Accessing / updating values

To get or update the value the `value` getter/setter should be used.

```dart
final value = search.value;
search.value = 'Updated value';
```

#### React widget

The `React` widget is similar to the `Obx` widget of `GetX`. It detects which Reactive values are used inside the function and subscribes to it changes, rebuilding the widget when a value changes.

```dart
final number = 0.ref;

// This function is called every time that `number` changes.
React(() {
  return Text(number.value.toString());
});
```


## Example

```dart
class Counter extends ReactStateful {
  Counter({super.key});

  final counter = 0.ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        React(() {
          return Text(counter.value.toString());
        }),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            counter.value++;
          },
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```