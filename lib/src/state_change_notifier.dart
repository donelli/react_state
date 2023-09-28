part of '../react_state.dart';

class StateChangeNotifier<T> {
  void _notify(T value) {
    for (final callback in _callbacks.keys) {
      callback(value);
    }
  }

  final _callbacks = <void Function(T), void>{};

  void addListener(void Function(T) callback) {
    _callbacks[callback] = null;
  }

  void removeListener(void Function(T) callback) {
    _callbacks.remove(callback);
  }
}
