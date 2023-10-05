part of '../../react_state.dart';

class ReactListRef<T> extends ReactInterface<List<T>> with ListMixin {
  ReactListRef([List<T>? value]) : super(value ?? []);

  @pragma("vm:prefer-inline")
  void batch(void Function(List<T> list) callback) {
    callback(_value);
    _notify(_value);
  }

  @pragma("vm:prefer-inline")
  @override
  int get length => value.length;

  @override
  set length(int len) {
    if (_value.length == len) {
      return;
    }

    _value.length = len;
    _notify(_value);
  }

  @pragma("vm:prefer-inline")
  @override
  operator [](int index) => value[index];

  @override
  void operator []=(int index, value) {
    if (_value[index] == value) {
      return;
    }

    _value[index] = value;
    _notify(_value);
  }

  set value(List<T> value) {
    if (_value == value) {
      return;
    }

    _value = value;
    _notify(_value);
  }

  @override
  T get first {
    if (length == 0) _IterableElementError.noElement();
    return _value[0];
  }

  T? get firstOrNull {
    if (length == 0) return null;
    return _value[0];
  }

  @override
  T get last {
    if (length == 0) _IterableElementError.noElement();
    return _value[_value.length - 1];
  }

  T? get lastOrNull {
    if (length == 0) return null;
    return _value[_value.length - 1];
  }

  @override
  T get single {
    if (length == 0) throw _IterableElementError.noElement();
    if (_value.length > 1) throw _IterableElementError.tooMany();
    return _value[0];
  }

  @override
  void add(dynamic element) {
    _value.add(element);
    _notify(_value);
  }

  @override
  void addAll(Iterable<dynamic> iterable) {
    int i = _value.length;
    final initialLength = i;

    for (final element in iterable) {
      assert(_value.length == i || (throw ConcurrentModificationError(this)));
      _value.add(element);
      i++;
    }

    if (i != initialLength) {
      _notify(_value);
    }
  }

  @override
  bool any(bool Function(T element) test) {
    int length = this.length;
    for (int i = 0; i < length; i++) {
      if (test(_value[i])) return true;
      if (length != _value.length) {
        throw ConcurrentModificationError(this);
      }
    }
    return false;
  }

  void assign(T item) {
    _value.clear();
    _value.add(item);
    _notify(_value);
  }

  void assignAll(Iterable<T> items) {
    _value.clear();
    addAll(items);
  }

  void replaceOne(T oldValue, T newValue) {
    final index = _value.indexOf(oldValue);
    if (index == -1) {
      throw ArgumentError.value(oldValue, "oldValue", "Not found");
    }

    _value[index] = newValue;
    _notify(_value);
  }
}

abstract class _IterableElementError {
  const _IterableElementError._();

  /// Error thrown thrown by, e.g., [Iterable.first] when there is no result.
  static StateError noElement() => StateError("No element");

  /// Error thrown by, e.g., [Iterable.single] if there are too many results.
  static StateError tooMany() => StateError("Too many elements");

  /// Error thrown by, e.g., [List.setRange] if there are too few elements.
  // static StateError tooFew() => StateError("Too few elements");
}
