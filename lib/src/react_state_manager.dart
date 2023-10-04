part of '../react_state.dart';

class ReactStateManager {
  ReactStateManager._internal();
  static final ReactStateManager instance = ReactStateManager._internal();

  final states = <ReactReactiveListener>[];

  final allowReactiveValueStack = <bool>[];

  void addRx<T>(ReactInterface<T> value) {
    if (states.isEmpty) {
      return;
    }

    states.last.addRx(value);
  }

  bool get canDeclareReactValues =>
      allowReactiveValueStack.isEmpty || allowReactiveValueStack.last;

  @pragma("vm:prefer-inline")
  void addListener(ReactReactiveListener listener) {
    states.add(listener);
  }

  @pragma("vm:prefer-inline")
  void removeListener(ReactReactiveListener listener) {
    states.remove(listener);
  }

  @pragma("vm:prefer-inline")
  void _onComputedCalculateStart(ReactReactiveListener state) {
    addListener(state);
    allowReactiveValueStack.add(false);
  }

  @pragma("vm:prefer-inline")
  void _onComputedCalculateEnd() {
    allowReactiveValueStack.removeLast();
    states.removeLast();
  }

  @pragma("vm:prefer-inline")
  void _onComputedDeclareStart() {
    allowReactiveValueStack.add(true);
  }

  @pragma("vm:prefer-inline")
  void _onComputedDeclareEnd() {
    allowReactiveValueStack.removeLast();
  }

  @pragma("vm:prefer-inline")
  void _onReactWidgetBuildStart(ReactReactiveListener state) {
    states.add(state);
    allowReactiveValueStack.add(false);
  }

  @pragma("vm:prefer-inline")
  void _onReactWidgetBuildStartEnd() {
    allowReactiveValueStack.removeLast();
    states.removeLast();
  }
}

abstract class ReactReactiveListener {
  void addRx<T>(ReactInterface<T> rx);
}
