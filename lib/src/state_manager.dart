part of '../react_state.dart';

class StateManager {
  static final states = <_ReactState>[];

  static void addRx<T>(ReactValue<T> value) {
    if (states.isEmpty) {
      return;
    }

    states.last.addRx(value);
  }
}
