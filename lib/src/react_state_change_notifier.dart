part of '../react_state.dart';

class ReactStateChangeNotifier<T> {
  void _notify(T value) {
    for (final callback in _callbacks.keys) {
      if (callback is void Function(T)) {
        callback(value);
      } else {
        callback();
      }
    }
  }

  final _callbacks = <Function, void>{};

  void addListener(void Function(T) callback) {
    _callbacks[callback] = null;
  }

  void removeListener(void Function(T) callback) {
    _callbacks.remove(callback);
  }

  void addListenerValueless(void Function() callback) {
    _callbacks[callback] = null;
  }

  void removeListenerValueless(void Function() callback) {
    _callbacks.remove(callback);
  }
}
