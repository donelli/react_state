part of '../react_state.dart';

class React extends StatefulWidget {
  const React(
    this.builder, {
    super.key,
  });

  final Widget Function() builder;

  static ReactUnmodifiableObject<T> computed<T extends Object>(
    T Function() computeFunction, {
    bool immediate = false,
  }) {
    return ComputedValue<T>.create(
      computeFunction: computeFunction,
      immediate: immediate,
    );
  }

  static void disposeComputed<T>(ReactUnmodifiableObject<T> value) {
    if (value is! ComputedValue) {
      return;
    }

    (value as ComputedValue)._dispose();
  }

  @override
  State<React> createState() => _ReactState();
}

class _ReactState extends State<React> implements ReactiveListener {
  final _values = <ReactValue<dynamic>, void>{};

  @override
  void addRx<T>(ReactValue<T> rx) {
    if (_values.containsKey(rx)) {
      return;
    }

    rx.addListener(_refresh);
    _values[rx] = null;
  }

  void _refresh<T>(T _) {
    setState(() {});
  }

  @override
  void deactivate() {
    _removeListeners();
    super.deactivate();
  }

  void _removeListeners() {
    for (final rx in _values.keys) {
      rx.removeListener(_refresh);
    }
    _values.clear();
  }

  @override
  Widget build(BuildContext context) {
    // FIXME: for now, this is executed every time, and it should.
    // But we can make this smarter and don't remove listeners if nothing has changed!
    _removeListeners();
    StateManager.states.add(this);

    final component = widget.builder();

    if (StateManager.states.last == this) {
      StateManager.states.removeLast();
    } else {
      assert(false, 'Reactive widget must be the last widget in the tree');
    }

    return component;
  }
}
