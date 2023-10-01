part of '../../react_state.dart';

class ReactValueDebounced<T> extends ReactValue<T> {
  ReactValueDebounced(T value, this.duration) : super(value);

  Timer? _timer;
  T? _debouncedValue;
  final Duration duration;

  @override
  set value(T value) {
    _debouncedValue = value;

    _timer?.cancel();
    _timer = Timer(duration, _updatedValueAndDisposeTimer);
  }

  void _updatedValueAndDisposeTimer() {
    _value = _debouncedValue as T;
    _notify(_value);
    _timer!.cancel();
    _timer = null;
    _debouncedValue = null;
  }
}
