part of '../../react_state.dart';

mixin ReactState {
  final _watchers = <ReactInterface, List<Function>>{};
  final _computedValues = <ReactUnmodifiableObject<Object>>[];

  @mustCallSuper
  void dispose() {
    for (final watcher in _watchers.entries) {
      for (final callback in watcher.value) {
        if (callback is void Function()) {
          watcher.key.removeListenerValueless(callback);
        } else {
          watcher.key.removeListener(callback as void Function(dynamic));
        }
      }
    }

    for (final computedValue in _computedValues) {
      React.disposeComputed(computedValue);
    }
  }

  ReactUnmodifiableObject<T> computed<T extends Object>(
    T Function() computeFunction,
  ) {
    final value = React.computed<T>(computeFunction);
    _computedValues.add(value);
    return value;
  }

  void watch(List<ReactInterface> values, void Function() callback) {
    for (final value in values) {
      if (!_watchers.containsKey(value)) {
        _watchers[value] = [];
      }

      _watchers[value]!.add(callback);
      value.addListenerValueless(callback);
    }
  }

  @pragma('vm:prefer-inline')
  void watchOne<T>(ReactInterface<T> value, void Function(T value) callback) {
    if (!_watchers.containsKey(value)) {
      _watchers[value] = [];
    }

    _watchers[value]!.add(callback);
    value.addListener(callback);
  }

  @pragma('vm:prefer-inline')
  ReactValue<T> ref<T extends Object>(T initialValue) {
    return ReactValue(initialValue);
  }
}
