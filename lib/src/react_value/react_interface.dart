part of '../../react_state.dart';

abstract class ReactInterface<T> extends ReactStateChangeNotifier<T> {
  ReactInterface(T value)
      : assert(
          ReactStateManager.instance.canDeclareReactValues,
          'Declaring reactive values inside the React widget or compute function is not allowed!',
        ),
        _value = value;

  // ignore: prefer_final_fields
  T _value;

  @pragma('vm:prefer-inline')
  T get value {
    _addRefToListeners();
    return _value;
  }

  @pragma('vm:prefer-inline')
  void _addRefToListeners() {
    ReactStateManager.instance.addRefListener(this);
  }

  @pragma('vm:prefer-inline')
  T get valueWithoutSubscription => _value;

  @pragma('vm:prefer-inline')
  void notify() {
    _notify(_value);
  }
}
