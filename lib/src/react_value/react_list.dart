part of '../../react_state.dart';

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
    if (_value[index] == value) {
      return;
    }

    _value[index] = value;
    _notify(_value);
  }

  @override
  T get first {
    if (length == 0) throw StateError("No element");
    return _value[0];
  }

  T? get firstOrNull {
    if (length == 0) return null;
    return _value[0];
  }

  @override
  T get last {
    if (length == 0) throw StateError("No element");
    return _value[_value.length - 1];
  }

  T? get lastOrNull {
    if (length == 0) return null;
    return _value[_value.length - 1];
  }
}
