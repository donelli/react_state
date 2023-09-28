part of '../react_state.dart';

abstract class ReactValue<T> extends StateChangeNotifier<T> {
  ReactValue(T value) : _value = value;

  T _value;

  T get value {
    StateManager.addRx(this);
    return _value;
  }
}

// Primitive

class ReactPrim<T> extends ReactValue<T> {
  ReactPrim(T value) : super(value);

  set value(T value) {
    if (_value == value) {
      return;
    }

    _value = value;
    _notify(_value);
  }
}

// List

class ReactList<T> extends ReactValue<List<T>> with ListMixin {
  ReactList(List<T> value) : super(value);

  @pragma("vm:prefer-inline")
  void batch(void Function(List<T> list) callback) {
    callback(_value);
    _notify(_value);
  }

  @pragma("vm:prefer-inline")
  @override
  int get length => value.length;

  @override
  set length(int len) {}

  @pragma("vm:prefer-inline")
  @override
  operator [](int index) => value[index];

  @override
  void operator []=(int index, value) {
    _value[index] = value;
    _notify(_value);
  }
}

// Map

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
