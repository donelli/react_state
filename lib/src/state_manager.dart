part of '../react_state.dart';

class StateManager {
  static final states = <ReactiveListener>[];

  static void addRx<T>(ReactInterface<T> value) {
    if (states.isEmpty) {
      return;
    }

    states.last.addRx(value);
  }
}

abstract class ReactiveListener {
  void addRx<T>(ReactInterface<T> rx);
}
