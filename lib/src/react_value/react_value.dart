part of '../../react_state.dart';

abstract class ReactValue<T> extends StateChangeNotifier<T> {
  ReactValue(T value) : _value = value;

  // ignore: prefer_final_fields
  T _value;

  T get value {
    StateManager.addRx(this);
    return _value;
  }

  T get valueWithoutSubscription => _value;
}
