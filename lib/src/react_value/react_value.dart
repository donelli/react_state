part of '../../react_state.dart';

class ReactRef<T> extends ReactInterface<T> {
  ReactRef(T value) : super(value);

  set value(T value) {
    if (_value == value) {
      return;
    }

    _value = value;
    _notify(_value);
  }
}
