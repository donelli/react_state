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
  Iterable<K> get keys => value.keys;

  @override
  V? remove(Object? key) {
    final removedValue = _value.remove(key);

    if (removedValue != null) {
      _notify(_value);
    }

    return removedValue;
  }

  @override
  void addAll(Map<K, V> other) {
    var hasChanged = false;

    other.forEach((K key, V value) {
      if (_value[key] == value) {
        return;
      }

      _value[key] = value;
      hasChanged = true;
    });

    if (hasChanged) {
      _notify(_value);
    }
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    var hasChanged = false;

    for (var key in _value.keys) {
      final newValue = update(key, _value[key] as V);

      if (_value[key] == newValue) {
        continue;
      }

      _value[key] = newValue;
      hasChanged = true;
    }

    if (hasChanged) {
      _notify(_value);
    }
  }

  @override
  Iterable<MapEntry<K, V>> get entries {
    return keys.map((K key) => MapEntry<K, V>(key, _value[key] as V));
  }

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) transform) {
    var result = <K2, V2>{};
    for (var key in keys) {
      var entry = transform(key, _value[key] as V);
      result[entry.key] = entry.value;
    }
    return result;
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    bool hasChanged = false;

    for (var entry in newEntries) {
      if (_value[entry.key] == entry.value) {
        continue;
      }

      _value[entry.key] = entry.value;
      hasChanged = true;
    }

    if (hasChanged) {
      _notify(_value);
    }
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    var keysToRemove = <K>[];
    for (var key in _value.keys) {
      if (test(key, _value[key] as V)) keysToRemove.add(key);
    }
    for (var key in keysToRemove) {
      _value.remove(key);
    }

    if (keysToRemove.isNotEmpty) {
      _notify(_value);
    }
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    if (_value.containsKey(key)) {
      final updatedValue = update(_value[key] as V);

      if (_value[key] != updatedValue) {
        _value[key] = updatedValue;
        _notify(_value);
      }

      return updatedValue;
    }

    if (ifAbsent != null) {
      final newValue = ifAbsent();

      _value[key] = newValue;
      _notify(_value);

      return newValue;
    }

    throw ArgumentError.value(key, "key", "Key not in map.");
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    if (_value.containsKey(key)) {
      return _value[key] as V;
    }
    return this[key] = ifAbsent();
  }

  @override
  bool containsValue(Object? value) {
    for (K key in keys) {
      if (_value[key] == value) return true;
    }
    return false;
  }

  @override
  void forEach(void Function(K key, V value) action) {
    for (K key in keys) {
      action(key, _value[key] as V);
    }
  }

  @override
  Iterable<V> get values => _ReactMapValuesIterable<K, V>(this);
}
