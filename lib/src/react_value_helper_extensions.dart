part of '../react_state.dart';

extension ReactValueBoolExtension on ReactValue<bool> {
  void toggle() => value = !value;
}
