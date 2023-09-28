part of '../../react_state.dart';

class ReactMap<K, V> extends ReactValue<Map<K, V>> with MapMixin<K, V> {
  ReactMap(Map<K, V> value) : super(value);

  @pragma("vm:prefer-inline")
  @override
  V? operator [](Object? key) => value[key];

  @override
  void operator []=(K key, V value) {
    if (_value[key] == value) {
      return;
    }

    _value[key] = value;
    _notify(_value);
  }

  @override
  void clear() {
    if (_value.isEmpty) {
      return;
    }

    _value.clear();
    _notify(_value);
  }

  @pragma("vm:prefer-inline")
  @override
  Iterable<K> get keys => _value.keys;

  @override
  V? remove(Object? key) {
    final removedValue = _value.remove(key);

    if (removedValue != null) {
      _notify(_value);
    }

    return removedValue;
  }
}
