part of '../react_state.dart';

class React extends StatefulWidget {
  const React(
    this.builder, {
    super.key,
  });

  final Widget Function() builder;

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

    rx.addListener(refresh);
    _values[rx] = null;
  }

  void refresh<T>(T _) {
    setState(() {});
  }

  @override
  void dispose() {
    for (final rx in _values.keys) {
      rx.removeListener(refresh);
    }
    _values.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
