part of '../react_state.dart';

class ReactStateManager {
  static final states = <ReactReactiveListener>[];

  static final allowReactiveValueStack = <bool>[];

  static void addRx<T>(ReactInterface<T> value) {
    if (states.isEmpty) {
      return;
    }

    states.last.addRx(value);
  }

  static bool get canDeclareReactValues =>
      allowReactiveValueStack.isEmpty || allowReactiveValueStack.last;
}

abstract class ReactReactiveListener {
  void addRx<T>(ReactInterface<T> rx);
}
