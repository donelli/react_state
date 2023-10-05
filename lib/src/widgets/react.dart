part of '../../react_state.dart';

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
    ReactStateManager.instance._onComputedDeclareStart();
    final value = ComputedValue<T>.create(
      computeFunction: computeFunction,
      immediate: immediate,
    );
    ReactStateManager.instance._onComputedDeclareEnd();

    return value;
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

class _ReactState extends State<React> implements ReactReactiveListener {
  final _refs = <ReactInterface<dynamic>, void>{};

  @override
  void addRef<T>(ReactInterface<T> ref) {
    if (_refs.containsKey(ref)) {
      return;
    }

    ref.addListener(_refresh);
    _refs[ref] = null;
  }

  void _refresh<T>(T _) {
    setState(() {});
  }

  @override
  void deactivate() {
    _removeListeners();
    super.deactivate();
  }

  @override
  void reassemble() {
    _refs.clear();
    super.reassemble();
  }

  void _removeListeners() {
    for (final ref in _refs.keys) {
      ref.removeListener(_refresh);
    }
    _refs.clear();
  }

  @override
  Widget build(BuildContext context) {
    // FIXME: for now, this is executed every time, and it should.
    // But we can make this smarter and don't remove listeners if nothing has changed!
    _removeListeners();

    ReactStateManager.instance._onReactWidgetBuildStart(this);
    final component = widget.builder();
    ReactStateManager.instance._onReactWidgetBuildStartEnd();

    return component;
  }
}
