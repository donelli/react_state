part of '../../react_state.dart';

class ReactListRef<T> extends ReactInterface<List<T>> with ListMixin<T> {
  ReactListRef([List<T>? value]) : super(value ?? []);

  @pragma("vm:prefer-inline")
  void batch(void Function(List<T> list) callback) {
    callback(_value);
    notify();
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
    notify();
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
    notify();
  }

  set value(List<T> value) {
    if (_value == value) {
      return;
    }

    _value = value;
    notify();
  }

  @override
  T get first {
    _addRefToListeners();
    return _value.first;
  }

  T? get firstOrNull {
    if (length == 0) return null;
    return _value[0];
  }

  @override
  T get last {
    _addRefToListeners();
    return _value.last;
  }

  T? get lastOrNull {
    if (length == 0) return null;
    return _value[_value.length - 1];
  }

  @override
  T get single {
    _addRefToListeners();
    return _value.single;
  }

  @override
  void add(dynamic element) {
    _value.add(element);
    notify();
  }

  @override
  void addAll(Iterable<T> iterable) {
    return runAndNotifyIfLengthChanged(
      () => _value.addAll(iterable),
    );
  }

  @override
  bool any(bool Function(T element) test) {
    _addRefToListeners();
    return _value.any(test);
  }

  void assign(T item) {
    _value.clear();
    _value.add(item);
    notify();
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
    notify();
  }

  @override
  T removeAt(int index) {
    final removedItem = _value.removeAt(index);
    notify();
    return removedItem;
  }

  @override
  bool remove(Object? element) {
    final removed = _value.remove(element);

    if (removed) {
      notify();
    }

    return removed;
  }

  @override
  T removeLast() {
    final removedItem = _value.removeLast();
    notify();
    return removedItem;
  }

  @override
  void removeRange(int start, int end) {
    if (start == end) {
      return;
    }
    _value.removeRange(start, end);
    notify();
  }

  @override
  void removeWhere(bool Function(T element) test) {
    return runAndNotifyIfLengthChanged(
      () => _value.removeWhere(test),
    );
  }

  @pragma("vm:prefer-inline")
  R runAndNotifyIfLengthChanged<R>(R Function() callback) {
    final initialLength = _value.length;

    final res = callback();

    if (_value.length != initialLength) {
      notify();
    }

    return res;
  }
}
