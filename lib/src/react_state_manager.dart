part of '../react_state.dart';

class ReactStateManager {
  ReactStateManager._internal();
  static final ReactStateManager instance = ReactStateManager._internal();

  final _listeners = <ReactReactiveListener>[];

  final allowReactiveValueStack = <bool>[];

  void addRefListener<T>(ReactInterface<T> value) {
    if (_listeners.isEmpty) {
      return;
    }

    _listeners.last.addRef(value);
  }

  bool get canDeclareReactValues =>
      allowReactiveValueStack.isEmpty || allowReactiveValueStack.last;

  @pragma("vm:prefer-inline")
  void addListener(ReactReactiveListener listener) {
    _listeners.add(listener);
  }

  @pragma("vm:prefer-inline")
  void removeListener(ReactReactiveListener listener) {
    _listeners.remove(listener);
  }

  @pragma("vm:prefer-inline")
  void _onComputedCalculateStart(ReactReactiveListener state) {
    addListener(state);
    allowReactiveValueStack.add(false);
  }

  @pragma("vm:prefer-inline")
  void _onComputedCalculateEnd() {
    allowReactiveValueStack.removeLast();
    _listeners.removeLast();
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
    _listeners.add(state);
    allowReactiveValueStack.add(false);
  }

  @pragma("vm:prefer-inline")
  void _onReactWidgetBuildStartEnd() {
    allowReactiveValueStack.removeLast();
    _listeners.removeLast();
  }
}

abstract class ReactReactiveListener {
  void addRef<T>(ReactInterface<T> ref);
}
