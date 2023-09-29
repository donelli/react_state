part of '../../react_state.dart';

class ReactObject<T> extends ReactValue<T> {
  ReactObject(T value) : super(value);

  set value(T value) {
    if (_value == value) {
      return;
    }

    _value = value;
    _notify(_value);
  }
}
