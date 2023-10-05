part of '../react_state.dart';

extension ReactValueBoolExtension on ReactRef<bool> {
  void toggle() => value = !value;
}
