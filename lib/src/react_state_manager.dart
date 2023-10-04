part of '../react_state.dart';

class ReactStateManager {
  static final states = <ReactReactiveListener>[];

  static void addRx<T>(ReactInterface<T> value) {
    if (states.isEmpty) {
      return;
    }

    states.last.addRx(value);
  }
}

abstract class ReactReactiveListener {
  void addRx<T>(ReactInterface<T> rx);
}
