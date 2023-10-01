part of '../../react_state.dart';

class ReactValue<T> extends ReactInterface<T> {
  ReactValue(T value) : super(value);

  set value(T value) {
    if (_value == value) {
      return;
    }

    _value = value;
    _notify(_value);
  }
}
