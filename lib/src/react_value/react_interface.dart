part of '../../react_state.dart';

abstract class ReactInterface<T> extends StateChangeNotifier<T> {
  ReactInterface(T value) : _value = value;

  // ignore: prefer_final_fields
  T _value;

  T get value {
    StateManager.addRx(this);
    return _value;
  }

  T get valueWithoutSubscription => _value;
}
