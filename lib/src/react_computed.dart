part of '../react_state.dart';

class ComputedValue<T> extends ReactUnmodifiableObject<T> {
  ComputedValue._({
    required this.computeFunction,
    this.immediate = false,
    required T initialValue,
    required _SimpleReactiveListener listener,
  })  : _listener = listener,
        super(initialValue);

  factory ComputedValue.create({
    required T Function() computeFunction,
    bool immediate = false,
  }) {
    final listener = _SimpleReactiveListener();
    ReactStateManager.instance._onComputedCalculateStart(listener);
    final initialValue = computeFunction();
    ReactStateManager.instance._onComputedCalculateEnd();

    final state = ComputedValue._(
      computeFunction: computeFunction,
      immediate: immediate,
      initialValue: initialValue,
      listener: listener,
    );

    for (var value in listener.values) {
      value.addListener(state._scheduleCalculate);
    }

    return state;
  }

  void _scheduleCalculate(void _) {
    if (immediate) {
      return _calculate();
    }

    if (isComputeScheduled) {
      return;
    }

    isComputeScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) => _calculate());
    return;
  }

  void _calculate() {
    ReactStateManager.instance._onComputedCalculateStart(
      _IgnoreReactiveListener(),
    );
    final newValue = computeFunction();
    ReactStateManager.instance._onComputedCalculateEnd();

    isComputeScheduled = false;

    if (_value == newValue) {
      return;
    }

    _value = newValue;
    _notify(newValue);
  }

  void _dispose() {
    for (var value in _listener.values) {
      value.removeListener(_scheduleCalculate);
    }
    _listener.values.clear();
  }

  final T Function() computeFunction;
  final bool immediate;
  final _SimpleReactiveListener _listener;
  bool isComputeScheduled = false;
}

class _SimpleReactiveListener extends ReactReactiveListener {
  _SimpleReactiveListener();

  final values = <ReactInterface<dynamic>>[];

  @override
  void addRef<T>(ReactInterface<T> ref) {
    values.add(ref);
  }
}

class _IgnoreReactiveListener extends ReactReactiveListener {
  @override
  void addRef<T>(ReactInterface<T> ref) {}
}
