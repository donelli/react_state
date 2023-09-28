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
    _value[index] = value;
    _notify(_value);
  }
}
