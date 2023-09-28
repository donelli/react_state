part of '../../react_state.dart';

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
