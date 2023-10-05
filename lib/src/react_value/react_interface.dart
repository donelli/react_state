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

  T get value {
    ReactStateManager.instance.addRefListener(this);
    return _value;
  }

  T get valueWithoutSubscription => _value;
}
